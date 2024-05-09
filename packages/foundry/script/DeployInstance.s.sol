// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {GitcoinPassportEligibility} from
    "../contracts/GitcoinPassportEligibility.sol";
import {HatsModuleFactory} from "hats-module/HatsModuleFactory.sol";

contract DeployInstance is Script {
    HatsModuleFactory public constant FACTORY =
        HatsModuleFactory(0xfE661c01891172046feE16D3a57c3Cf456729efA);
    address public implementation;
    address public instance;
    bytes32 public SALT = bytes32(abi.encode(0x4a75)); // ~ H(4) A(a) T(7) S(5)

    // default values
    bool internal _verbose = true;
    uint256 public targetHat;
    uint256 public scoreCriterion;
    address public gitcoinPassportDecoder;

    /// @dev Override default values, if desired
    function prepare(
        bool verbose,
        uint256 _targetHat,
        address _implementation,
        address _gitcoinPassportDecoder,
        uint256 _scoreCriterion
    ) public {
        _verbose = verbose;
        targetHat = _targetHat;
        implementation = _implementation;
        gitcoinPassportDecoder = _gitcoinPassportDecoder;
        scoreCriterion = _scoreCriterion;
    }

    /// @dev Set up the deployer via their private key from the environment
    function deployer() public returns (address) {
        uint256 privKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        return vm.rememberKey(privKey);
    }

    function _log(string memory prefix) internal view {
        if (_verbose) {
            console2.log(string.concat(prefix, "Deployed instance:"), instance);
        }
    }

    /// @dev Deploy the contract to a deterministic address via forge's create2 deployer factory.
    function run() public virtual returns (address) {
        vm.startBroadcast(deployer());

        instance = FACTORY.createHatsModule(
            implementation,
            targetHat, // hatId
            abi.encodePacked(gitcoinPassportDecoder, scoreCriterion), // otherImmutableArgs
            abi.encode() // initArgs
        );

        vm.stopBroadcast();

        _log("");

        return instance;
    }
}
