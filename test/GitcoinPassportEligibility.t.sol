// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test, console2 } from "forge-std/Test.sol";
import { GitcoinPassportEligibility, GitcoinResolverLike } from "../src/GitcoinPassportEligibility.sol";
import { DeployImplementation, DeployInstance } from "../script/Deploy.s.sol";
// import { IGitcoinResolver } from "eas-proxy/contracts/IGitcoinResolver.sol";
import { Attestation, IEAS } from "eas-contracts/contracts/IEAS.sol";
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

  string public MODULE_VERSION;

  GitcoinResolverLike public constant GITCOIN_RESOLVER = GitcoinResolverLike(0xc94aBf0292Ac04AAC18C251d9C8169a8dd2BBbDC);
  IEAS public constant EAS = IEAS(0x4200000000000000000000000000000000000021);
  bytes32 public constant SCORE_SCHEMA = 0x6ab5d34260fca0cfcf0e76e96d439cace6aa7c3c019d7c4580ed52c6845e9c89;
  uint256 public scoreCriterion = 20e18; // the gitcoin standard threshold

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

contract UnitTests is WithInstanceTest {
  function test_getScore() public {
    // TODO replace with a test passport for more comprehensive testing
    address wearer = 0xA7a5A2745f10D5C23d75a6fd228A408cEDe1CAE5;

    // get the score
    uint256 score = instance.getScore(wearer);

    console2.log("my score:", score);
  }

  function test_getWearerStatus() public {
    // TODO replace with a test passport for more com
    address wearer = 0xA7a5A2745f10D5C23d75a6fd228A408cEDe1CAE5;

    // get the wearer status
    (bool eligible, bool standing) = instance.getWearerStatus(wearer, targetHat);

    assertTrue(eligible, "wearer should be eligible");
    assertTrue(standing, "wearer should be in good standing");
  }
}
