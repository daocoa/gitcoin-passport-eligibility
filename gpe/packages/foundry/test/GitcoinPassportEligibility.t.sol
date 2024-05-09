// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {GitcoinPassportEligibility} from
    "../contracts/GitcoinPassportEligibility.sol";
import {IGitcoinPassportDecoder} from
    "../lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol";
import {IGitcoinResolver} from "../lib/eas-proxy/contracts/IGitcoinResolver.sol";
// import { GitcoinPassportDecoder } from "../lib/eas-proxy/contracts/GitcoinPassportDecoder.sol";
import {
    Attestation,
    AttestationRequest,
    AttestationRequestData,
    IEAS,
    RevocationRequest,
    RevocationRequestData
} from "../lib/eas-contracts/contracts/IEAS.sol";
import {DeployImplementation} from "../script/DeployImplementation.s.sol";
import {DeployInstance} from "../script/DeployInstance.s.sol";

import {IHats} from "hats-protocol/Interfaces/IHats.sol";

contract ModuleTest is DeployImplementation, Test {
    /// @dev variables inherited from DeployImplementation script
    // GitcoinPassportEligibility public implementation;
    // bytes32 public SALT;

    uint256 public fork;
    uint256 public BLOCK_NUMBER = 116_488_798;
    IHats public HATS = IHats(0x3bc1A0Ad72417f2d411118085256fC53CBdDd137); // v1.hatsprotocol.eth

    // HatsModuleFactory public factory = HatsModuleFactory(0xfE661c01891172046feE16D3a57c3Cf456729efA);
    GitcoinPassportEligibility public instance;
    DeployInstance public deployInstance;
    uint256 public targetHat;

    address public passportHolder = makeAddr("passportHolder");
    bool public human;
    uint256 public score;
    uint256 public scoreret;
    uint64 public expiry;
    uint8 public decimalsret;
    address public wearer;
    bytes32 public attestation;

    string public MODULE_VERSION;

    address public constant GITCOIN_ATTESTER =
        0x843829986e895facd330486a61Ebee9E1f1adB1a;
    IGitcoinResolver public constant GITCOIN_RESOLVER =
        IGitcoinResolver(0xc94aBf0292Ac04AAC18C251d9C8169a8dd2BBbDC);
    IEAS public constant EAS = IEAS(0x4200000000000000000000000000000000000021);
    bytes32 public constant SCORE_SCHEMA =
        0x6ab5d34260fca0cfcf0e76e96d439cace6aa7c3c019d7c4580ed52c6845e9c89;
    uint8 public constant DECIMALS = 4;

    address public resolverOwner;
    address public cacher;

    // gitcoin passport custom errors
    error ZeroValue();
    error AttestationNotFound();
    error AttestationExpired(uint64 expirationTime);
    error ZeroThreshold();
    error ZeroMaxScoreAge();
    error ScoreDoesNotMeetThreshold(uint256 score);
    error AccessDenied();
    error InsufficientValue();
    error NotPayable();
    error NotAllowlisted();
    error InvalidAttester();

    IGitcoinPassportDecoder public GITCOIN_PASSPORT_DECODER =
        IGitcoinPassportDecoder(0x5558D441779Eca04A329BcD6b47830D2C6607769);

    uint256 public scoreCriterion;

    function _deployInstance(uint256 _criterion)
        internal
        returns (GitcoinPassportEligibility)
    {
        // prepare the script with the necessary argss
        deployInstance.prepare(
            false,
            targetHat,
            address(implementation),
            address(GITCOIN_PASSPORT_DECODER),
            _criterion
        );

        // run the script
        return GitcoinPassportEligibility(deployInstance.run());
    }

    /// @dev creates a gitcoin passport score attestation
    function createScoreAttestation(
        address _recipient,
        uint256 _score,
        uint64 _expiry
    ) public returns (bytes32) {
        // build the score attestation
        bytes memory scoreAttestationData =
            abi.encode(_score, uint32(1), DECIMALS);

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
        return EAS.attest(request);
    }

    /// @dev revokes a gitcoin passport score attestation
    function revokeScoreAttestation(bytes32 _attestationUID) public {
        // build the revocation request
        RevocationRequest memory request = RevocationRequest({
            schema: SCORE_SCHEMA,
            data: RevocationRequestData({uid: _attestationUID, value: 0})
        });

        // score attestations must be revoked by the GitcoinAttester contract
        vm.prank(GITCOIN_ATTESTER);
        EAS.revoke(request);
    }

    function setUp() public virtual {
        // create and activate a fork, at BLOCK_NUMBER
        fork = vm.createSelectFork(vm.rpcUrl("optimism"), BLOCK_NUMBER);

        // deploy implementation via the script
        prepare(false, MODULE_VERSION);
        run();

        // deploy the DeployInstance script contract
        deployInstance = new DeployInstance();

        // set up the hats
        targetHat = 1;
    }
}

contract Deployment is ModuleTest {
    function setUp() public override {
        super.setUp();
        // set up the score criterion
        scoreCriterion = 50;

        // deploy the instance
        instance = _deployInstance(scoreCriterion);
    }
    /// @dev ensure that both the implementation and instance are properly initialized

    function test_initialization() public {
        // implementation
        vm.expectRevert("Initializable: contract is already initialized");
        implementation.setUp("setUp attempt");
        // instance
        vm.expectRevert("Initializable: contract is already initialized");
        instance.setUp("setUp attempt");
    }

    function test_version() public view {
        assertEq(instance.version(), MODULE_VERSION);
    }

    function test_implementation() public view {
        assertEq(address(instance.IMPLEMENTATION()), address(implementation));
    }

    function test_hats() public view {
        assertEq(address(instance.HATS()), address(HATS));
    }

    function test_hatId() public view {
        assertEq(instance.hatId(), targetHat);
    }

    function test_gitcoinPassportDecoder() public view {
        assertEq(
            address(instance.GITCOIN_PASSPORT_DECODER()),
            address(GITCOIN_PASSPORT_DECODER)
        );
    }

    function test_scoreCriterion() public view {
        assertEq(instance.SCORE_CRITERION(), scoreCriterion * 10 ** DECIMALS);
    }
}

contract IsHuman is ModuleTest {
    function test_exists_notRevoked_notExpired(
        uint256 _score,
        uint256 _criterion
    ) public {
        scoreCriterion = bound(_criterion, 0, 100);
        instance = _deployInstance(scoreCriterion);
        score = bound(_score, 1, 100) * 10 ** DECIMALS;
        expiry = uint64(block.timestamp + 1 days);
        wearer = passportHolder;

        // create a score attestation
        createScoreAttestation(wearer, score, expiry);

        // get the human designation
        human = instance.isHuman(wearer);

        if (scoreCriterion == 0) scoreCriterion = 20;
        assertEq(human, score >= scoreCriterion * 10 ** DECIMALS);
    }

    function test_doesNotExist() public {
        instance = _deployInstance(1);

        // don't create a score attestation
        wearer = passportHolder;

        assertFalse(instance.isHuman(wearer));
    }

    function test_exists_revoked_notExpired(
        uint256 _score,
        uint256 _criterion
    ) public {
        scoreCriterion = bound(_criterion, 0, 100);
        instance = _deployInstance(scoreCriterion);
        if (scoreCriterion == 0) scoreCriterion = 20;
        score = bound(_score, scoreCriterion, 100) * 10 ** DECIMALS;
        expiry = uint64(block.timestamp + 1 days);
        wearer = passportHolder;

        // create a score attestation
        attestation = createScoreAttestation(wearer, score, expiry);

        // the wearer should be human
        assertTrue(instance.isHuman(wearer));

        // revoke the attestation
        revokeScoreAttestation(attestation);

        // now the wearer should not be human
        assertFalse(instance.isHuman(wearer));
    }

    function test_exists_notRevoked_expired(
        uint256 _score,
        uint256 _criterion
    ) public {
        scoreCriterion = bound(_criterion, 0, 100);
        instance = _deployInstance(scoreCriterion);
        if (scoreCriterion == 0) scoreCriterion = 20;
        score = bound(_score, scoreCriterion, 100) * 10 ** DECIMALS;
        expiry = uint64(block.timestamp + 1 days);
        wearer = passportHolder;

        // create a score attestation
        attestation = createScoreAttestation(wearer, score, expiry);

        // the wearer should be human
        assertTrue(instance.isHuman(wearer));

        // fast forward to the expiry time
        vm.warp(expiry + 1);

        // now the wearer should not be human
        assertFalse(instance.isHuman(wearer));
    }
}

contract GetWearerStatus is ModuleTest {
    bool public eligible;
    bool public standing;

    function test_sufficientScore(uint256 _score, uint256 _criterion) public {
        scoreCriterion = bound(_criterion, 0, 100);
        instance = _deployInstance(scoreCriterion);
        if (scoreCriterion == 0) scoreCriterion = 20;
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

    function test_insufficientScore(
        uint256 _score,
        uint256 _criterion
    ) public {
        scoreCriterion = bound(_criterion, 0, 100);
        instance = _deployInstance(scoreCriterion);
        if (scoreCriterion == 0) scoreCriterion = 20;
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
        test_insufficientScore(0, 1);
    }

    function test_criterion(uint256 _criterion) public {
        scoreCriterion = bound(_criterion, 1, 100);
        test_sufficientScore(scoreCriterion, scoreCriterion);
    }

    function test_criterionMinus(uint256 _criterion) public {
        scoreCriterion = bound(_criterion, 1, 100);
        test_insufficientScore(scoreCriterion - 1, scoreCriterion);
    }

    function test_criterionPlus(uint256 _criterion) public {
        scoreCriterion = bound(_criterion, 0, 100);
        if (scoreCriterion == 0) scoreCriterion = 20;
        test_sufficientScore(scoreCriterion + 1, scoreCriterion);
    }

    function test_maxScore(uint256 _criterion) public {
        scoreCriterion = bound(_criterion, 0, 100);
        if (scoreCriterion == 0) scoreCriterion = 20;
        test_sufficientScore(100, scoreCriterion);
    }
}
