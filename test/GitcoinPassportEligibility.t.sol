// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test, console2 } from "forge-std/Test.sol";
import { GitcoinPassportEligibility, GitcoinResolverLike } from "../src/GitcoinPassportEligibility.sol";
import { DeployImplementation, DeployInstance } from "../script/Deploy.s.sol";
// import { IGitcoinResolver } from "eas-proxy/contracts/IGitcoinResolver.sol";
import {
  Attestation,
  AttestationRequest,
  AttestationRequestData,
  IEAS,
  RevocationRequest,
  RevocationRequestData
} from "eas-contracts/contracts/IEAS.sol";
import { IHats } from "hats-protocol/Interfaces/IHats.sol";

contract ModuleTest is DeployImplementation, Test {
  /// @dev variables inherited from DeployImplementation script
  // GitcoinPassportEligibility public implementation;
  // bytes32 public SALT;

  uint256 public fork;
  uint256 public BLOCK_NUMBER = 111_973_500;
  IHats public HATS = IHats(0x3bc1A0Ad72417f2d411118085256fC53CBdDd137); // v1.hatsprotocol.eth
  // HatsModuleFactory public factory = HatsModuleFactory(0xfE661c01891172046feE16D3a57c3Cf456729efA);
  GitcoinPassportEligibility public instance;
  bytes public otherImmutableArgs;
  bytes public initArgs;
  uint256 public targetHat;

  address public passportHolder = makeAddr("passportHolder");
  uint256 public score;
  uint256 public scoreret;
  uint64 public expiry;
  uint8 public decimalsret;
  address public wearer;
  bytes32 public attestation;

  string public MODULE_VERSION;

  GitcoinResolverLike public constant GITCOIN_RESOLVER = GitcoinResolverLike(0xc94aBf0292Ac04AAC18C251d9C8169a8dd2BBbDC);
  address public constant GITCOIN_ATTESTER = 0x843829986e895facd330486a61Ebee9E1f1adB1a;
  IEAS public constant EAS = IEAS(0x4200000000000000000000000000000000000021);
  bytes32 public constant SCORE_SCHEMA = 0x6ab5d34260fca0cfcf0e76e96d439cace6aa7c3c019d7c4580ed52c6845e9c89;
  uint8 public constant DECIMALS = 18;
  uint256 public scoreCriterion = 20; // the gitcoin standard threshold

  function setUp() public virtual {
    // create and activate a fork, at BLOCK_NUMBER
    fork = vm.createSelectFork(vm.rpcUrl("optimism"), BLOCK_NUMBER);

    // deploy implementation via the script
    prepare(false, MODULE_VERSION);
    run();
  }
}

contract WithInstanceTest is ModuleTest {
  function setUp() public virtual override {
    super.setUp();

    // set up the hats
    targetHat = 1;

    // deploy the DeployInstance script contract
    DeployInstance deployInstance = new DeployInstance();

    // prepare the script with the necessary args
    deployInstance.prepare(
      false, targetHat, address(implementation), address(EAS), address(GITCOIN_RESOLVER), SCORE_SCHEMA, scoreCriterion
    );

    // run the script
    instance = GitcoinPassportEligibility(deployInstance.run());
  }

  /// @dev creates a gitcoin passport score attestation
  function createScoreAttestation(address _recipient, uint256 _score, uint64 _expiry)
    public
    returns (bytes32 attestation)
  {
    // build the score attestation
    bytes memory scoreAttestationData = abi.encode(_score, uint32(1), DECIMALS);

    // build the attestation request
    AttestationRequest memory request = AttestationRequest({
      schema: SCORE_SCHEMA,
      data: AttestationRequestData({
        recipient: _recipient,
        expirationTime: _expiry,
        revocable: true,
        refUID: 0, // No reference UI
        data: scoreAttestationData,
        value: 0 // No value/ETH
       })
    });

    // score attestations must be made by the GitcoinAttester contract
    vm.prank(GITCOIN_ATTESTER);
    attestation = EAS.attest(request);
  }

  /// @dev revokes a gitcoin passport score attestation
  function revokeScoreAttestation(bytes32 _attestationUID) public {
    // build the revocation request
    RevocationRequest memory request =
      RevocationRequest({ schema: SCORE_SCHEMA, data: RevocationRequestData({ uid: _attestationUID, value: 0 }) });

    // score attestations must be revoked by the GitcoinAttester contract
    vm.prank(GITCOIN_ATTESTER);
    EAS.revoke(request);
  }
}

contract Deployment is WithInstanceTest {
  /// @dev ensure that both the implementation and instance are properly initialized
  function test_initialization() public {
    // implementation
    vm.expectRevert("Initializable: contract is already initialized");
    implementation.setUp("setUp attempt");
    // instance
    vm.expectRevert("Initializable: contract is already initialized");
    instance.setUp("setUp attempt");
  }

  function test_version() public {
    assertEq(instance.version(), MODULE_VERSION);
  }

  function test_implementation() public {
    assertEq(address(instance.IMPLEMENTATION()), address(implementation));
  }

  function test_hats() public {
    assertEq(address(instance.HATS()), address(HATS));
  }

  function test_hatId() public {
    assertEq(instance.hatId(), targetHat);
  }

  function test_eas() public {
    assertEq(address(instance.EAS()), address(EAS));
  }

  function test_gitcoinResolver() public {
    assertEq(address(instance.GITCOIN_RESOLVER()), address(GITCOIN_RESOLVER));
  }

  function test_scoreSchema() public {
    assertEq(instance.SCORE_SCHEMA(), SCORE_SCHEMA);
  }

  function test_scoreCriterion() public {
    assertEq(instance.SCORE_CRITERION(), scoreCriterion);
  }
}

contract GetScoreAndDecimals is WithInstanceTest {
  function test_exists_notRevoked_notExpired(uint256 _score) public {
    score = bound(_score, 1, 100) * 10 ** DECIMALS;
    expiry = uint64(block.timestamp + 1 days);
    wearer = passportHolder;

    // create a score attestation
    createScoreAttestation(wearer, score, expiry);

    // get the score and decimals
    (scoreret, decimalsret) = instance.getScoreAndDecimals(wearer);

    assertEq(scoreret, score, "wrong score");
    assertEq(decimalsret, DECIMALS, "wrong decimals");
  }

  function test_doesNotExist() public {
    // don't create a score attestation
    wearer = passportHolder;

    // get the score and decimals
    (scoreret, decimalsret) = instance.getScoreAndDecimals(wearer);

    assertEq(scoreret, 0, "wrong score");
    assertEq(decimalsret, 0, "wrong decimals");
  }

  function test_exists_revoked_notExpired(uint256 _score) public {
    score = bound(_score, 1, 100) * 10 ** DECIMALS;
    expiry = uint64(block.timestamp + 1 days);
    wearer = passportHolder;

    // create a score attestation
    attestation = createScoreAttestation(wearer, score, expiry);

    // the score should exist
    (scoreret, decimalsret) = instance.getScoreAndDecimals(wearer);
    assertEq(scoreret, score, "wrong score");
    assertEq(decimalsret, DECIMALS, "wrong decimals");

    // revoke the attestation
    revokeScoreAttestation(attestation);

    // get the score and decimals
    (scoreret, decimalsret) = instance.getScoreAndDecimals(wearer);

    // the score should be no longer exist
    assertEq(scoreret, 0, "wrong score");
    assertEq(decimalsret, 0, "wrong decimals");
  }

  function test_exists_notRevoked_expired(uint256 _score) public {
    score = bound(_score, 1, 100) * 10 ** DECIMALS;
    expiry = uint64(block.timestamp + 1 days);
    wearer = passportHolder;

    // create a score attestation
    createScoreAttestation(wearer, score, expiry);

    // the score should exist
    (scoreret, decimalsret) = instance.getScoreAndDecimals(wearer);
    assertEq(scoreret, score, "wrong score");
    assertEq(decimalsret, DECIMALS, "wrong decimals");

    // fast forward to the expiry time
    vm.warp(expiry);

    // get the score and decimals
    (scoreret, decimalsret) = instance.getScoreAndDecimals(wearer);

    // the score should be no longer exist
    assertEq(scoreret, 0, "wrong score");
    assertEq(decimalsret, 0, "wrong decimals");
  }
}

contract GetWearerStatus is WithInstanceTest {
  bool public eligible;
  bool public standing;

  function test_sufficientScore(uint256 _score) public {
    score = bound(_score, scoreCriterion, 100) * 10 ** DECIMALS;
    expiry = uint64(block.timestamp + 1 days);
    wearer = passportHolder;

    // create a score attestation
    createScoreAttestation(wearer, score, expiry);

    // get the wearer status
    (eligible, standing) = instance.getWearerStatus(wearer, targetHat);

    assertTrue(eligible, "wearer should be eligible");
    assertTrue(standing, "wearer should be in good standing");
  }

  function test_insufficientScore(uint256 _score) public {
    score = bound(_score, 0, scoreCriterion - 1) * 10 ** DECIMALS;
    expiry = uint64(block.timestamp + 1 days);
    wearer = passportHolder;

    // create a score attestation
    createScoreAttestation(wearer, score, expiry);

    // get the wearer status
    (eligible, standing) = instance.getWearerStatus(wearer, targetHat);

    assertFalse(eligible, "wearer should not be eligible");
    assertTrue(standing, "wearer should be in good standing");
  }

  function test_zeroScore() public {
    test_insufficientScore(0);
  }

  function test_criterion() public {
    test_sufficientScore(scoreCriterion);
  }

  function test_criterionMinus() public {
    test_insufficientScore(scoreCriterion - 1);
  }

  function test_criterionPlus() public {
    test_sufficientScore(scoreCriterion + 1);
  }

  function test_maxScore() public {
    test_sufficientScore(100);
  }
}
