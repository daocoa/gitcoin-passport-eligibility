//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";

import {DeployImplementation} from "./DeployImplementation.s.sol";
import {DeployInstance} from "./DeployInstance.s.sol";

contract DeployScript is ScaffoldETHDeploy {
    function run() external {
        DeployImplementation deployer = new DeployImplementation();
        deployer.run();

        exportDeployments();
    }

    function test() public {}
}
