# Aderyn Analysis Report

This report was generated by [Aderyn](https://github.com/Cyfrin/aderyn), a static analysis tool built by [Cyfrin](https://cyfrin.io), a blockchain security company. This report is not a substitute for manual audit or security review. It should not be relied upon for any purpose other than to assist in the identification of potential security vulnerabilities.
# Table of Contents

- [Summary](#summary)
  - [Files Summary](#files-summary)
  - [Files Details](#files-details)
  - [Issue Summary](#issue-summary)
- [High Issues](#high-issues)
  - [H-1: Unprotected initializer](#h-1-unprotected-initializer)
- [Low Issues](#low-issues)
  - [L-1: Centralization Risk for trusted owners](#l-1-centralization-risk-for-trusted-owners)
  - [L-2: Solidity pragma should be specific, not wide](#l-2-solidity-pragma-should-be-specific-not-wide)
  - [L-3: `public` functions not used internally could be marked `external`](#l-3-public-functions-not-used-internally-could-be-marked-external)
  - [L-4: Define and use `constant` variables instead of using literals](#l-4-define-and-use-constant-variables-instead-of-using-literals)
  - [L-5: Event is missing `indexed` fields](#l-5-event-is-missing-indexed-fields)
  - [L-6: PUSH0 is not supported by all chains](#l-6-push0-is-not-supported-by-all-chains)
  - [L-7: Empty Block](#l-7-empty-block)
  - [L-8: Unused Custom Error](#l-8-unused-custom-error)


# Summary

## Files Summary

| Key | Value |
| --- | --- |
| .sol Files | 9 |
| Total nSLOC | 413 |


## Files Details

| Filepath | nSLOC |
| --- | --- |
| contracts/GitcoinPassportDecoder.sol | 260 |
| contracts/GitcoinPassportEligibility.sol | 39 |
| contracts/HatsEligibilityModule.sol | 12 |
| contracts/HatsModule.sol | 28 |
| contracts/IHatsModule.sol | 10 |
| lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol | 14 |
| lib/hats-module/src/HatsEligibilityModule.sol | 12 |
| lib/hats-module/src/HatsModule.sol | 28 |
| lib/hats-module/src/interfaces/IHatsModule.sol | 10 |
| **Total** | **413** |


## Issue Summary

| Category | No. of Issues |
| --- | --- |
| High | 1 |
| Low | 8 |


# High Issues

## H-1: Unprotected initializer

Consider protecting the initializer functions with modifiers.

<details><summary>1 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 215](contracts/GitcoinPassportDecoder.sol#L215)

	```solidity
	  function _initCurrentVersion(string[] memory providers) internal {
	```

</details>



# Low Issues

## L-1: Centralization Risk for trusted owners

Contracts have owners with privileged rights to perform admin tasks and need to be trusted to not perform malicious updates or drain funds.

<details><summary>11 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 93](contracts/GitcoinPassportDecoder.sol#L93)

	```solidity
	  function pause() public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 97](contracts/GitcoinPassportDecoder.sol#L97)

	```solidity
	  function unpause() public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 101](contracts/GitcoinPassportDecoder.sol#L101)

	```solidity
	  function _authorizeUpgrade(address) internal override onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 115](contracts/GitcoinPassportDecoder.sol#L115)

	```solidity
	  function setEASAddress(address _easContractAddress) external onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 127](contracts/GitcoinPassportDecoder.sol#L127)

	```solidity
	  function setGitcoinResolver(address _gitcoinResolver) external onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 139](contracts/GitcoinPassportDecoder.sol#L139)

	```solidity
	  function setPassportSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 151](contracts/GitcoinPassportDecoder.sol#L151)

	```solidity
	  function setScoreSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 163](contracts/GitcoinPassportDecoder.sol#L163)

	```solidity
	  function setMaxScoreAge(uint64 _maxScoreAge) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 177](contracts/GitcoinPassportDecoder.sol#L177)

	```solidity
	  function setThreshold(uint256 _threshold) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 191](contracts/GitcoinPassportDecoder.sol#L191)

	```solidity
	  function addProviders(string[] memory providers) external onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 232](contracts/GitcoinPassportDecoder.sol#L232)

	```solidity
	  function createNewVersion(string[] memory providers) external onlyOwner {
	```

</details>



## L-2: Solidity pragma should be specific, not wide

Consider using a specific version of Solidity in your contracts instead of a wide version. For example, instead of `pragma solidity ^0.8.0;`, use `pragma solidity 0.8.0;`

<details><summary>9 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 2](contracts/GitcoinPassportDecoder.sol#L2)

	```solidity
	pragma solidity ^0.8.9;
	```

- Found in contracts/GitcoinPassportEligibility.sol [Line: 2](contracts/GitcoinPassportEligibility.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in contracts/HatsEligibilityModule.sol [Line: 2](contracts/HatsEligibilityModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in contracts/HatsModule.sol [Line: 2](contracts/HatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in contracts/IHatsModule.sol [Line: 2](contracts/IHatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol [Line: 2](lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol#L2)

	```solidity
	pragma solidity ^0.8.9;
	```

- Found in lib/hats-module/src/HatsEligibilityModule.sol [Line: 2](lib/hats-module/src/HatsEligibilityModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in lib/hats-module/src/HatsModule.sol [Line: 2](lib/hats-module/src/HatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in lib/hats-module/src/interfaces/IHatsModule.sol [Line: 2](lib/hats-module/src/interfaces/IHatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

</details>



## L-3: `public` functions not used internally could be marked `external`

Instead of marking a function as `public`, consider marking it as `external` if it is not used internally.

<details><summary>20 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 86](contracts/GitcoinPassportDecoder.sol#L86)

	```solidity
	  function initialize() public initializer {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 93](contracts/GitcoinPassportDecoder.sol#L93)

	```solidity
	  function pause() public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 97](contracts/GitcoinPassportDecoder.sol#L97)

	```solidity
	  function unpause() public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 107](contracts/GitcoinPassportDecoder.sol#L107)

	```solidity
	  function getProviders(uint32 version) public view returns (string[] memory) {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 139](contracts/GitcoinPassportDecoder.sol#L139)

	```solidity
	  function setPassportSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 151](contracts/GitcoinPassportDecoder.sol#L151)

	```solidity
	  function setScoreSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 163](contracts/GitcoinPassportDecoder.sol#L163)

	```solidity
	  function setMaxScoreAge(uint64 _maxScoreAge) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 177](contracts/GitcoinPassportDecoder.sol#L177)

	```solidity
	  function setThreshold(uint256 _threshold) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 464](contracts/GitcoinPassportDecoder.sol#L464)

	```solidity
	  function isHuman(address user) public view returns (bool) {
	```

- Found in contracts/GitcoinPassportEligibility.sol [Line: 63](contracts/GitcoinPassportEligibility.sol#L63)

	```solidity
	  function getWearerStatus(address wearer, uint256 /*_hatId*/ )
	```

- Found in contracts/HatsEligibilityModule.sol [Line: 19](contracts/HatsEligibilityModule.sol#L19)

	```solidity
	  function getWearerStatus(address _wearer, uint256 _hatId)
	```

- Found in contracts/HatsModule.sol [Line: 43](contracts/HatsModule.sol#L43)

	```solidity
	  function HATS() public pure returns (IHats) {
	```

- Found in contracts/HatsModule.sol [Line: 48](contracts/HatsModule.sol#L48)

	```solidity
	  function hatId() public pure returns (uint256) {
	```

- Found in contracts/HatsModule.sol [Line: 56](contracts/HatsModule.sol#L56)

	```solidity
	  function version() public view returns (string memory) {
	```

- Found in contracts/HatsModule.sol [Line: 65](contracts/HatsModule.sol#L65)

	```solidity
	  function setUp(bytes calldata _initData) public initializer {
	```

- Found in lib/hats-module/src/HatsEligibilityModule.sol [Line: 19](lib/hats-module/src/HatsEligibilityModule.sol#L19)

	```solidity
	  function getWearerStatus(address _wearer, uint256 _hatId)
	```

- Found in lib/hats-module/src/HatsModule.sol [Line: 43](lib/hats-module/src/HatsModule.sol#L43)

	```solidity
	  function HATS() public pure returns (IHats) {
	```

- Found in lib/hats-module/src/HatsModule.sol [Line: 48](lib/hats-module/src/HatsModule.sol#L48)

	```solidity
	  function hatId() public pure returns (uint256) {
	```

- Found in lib/hats-module/src/HatsModule.sol [Line: 56](lib/hats-module/src/HatsModule.sol#L56)

	```solidity
	  function version() public view returns (string memory) {
	```

- Found in lib/hats-module/src/HatsModule.sol [Line: 65](lib/hats-module/src/HatsModule.sol#L65)

	```solidity
	  function setUp(bytes calldata _initData) public initializer {
	```

</details>



## L-4: Define and use `constant` variables instead of using literals

If the same constant literal value is used multiple times, create a constant state variable and reference it throughout the contract.

<details><summary>9 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 324](contracts/GitcoinPassportDecoder.sol#L324)

	```solidity
	      for (uint256 j = 0; j < 256; ) {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 330](contracts/GitcoinPassportDecoder.sol#L330)

	```solidity
	        uint256 mappedProvidersIndex = i * 256 + j;
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 361](contracts/GitcoinPassportDecoder.sol#L361)

	```solidity
	        i += 256;
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 445](contracts/GitcoinPassportDecoder.sol#L445)

	```solidity
	    if (decimals > 4) {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 446](contracts/GitcoinPassportDecoder.sol#L446)

	```solidity
	      score /= 10 ** (decimals - 4);
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 447](contracts/GitcoinPassportDecoder.sol#L447)

	```solidity
	    } else if (decimals < 4) {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 448](contracts/GitcoinPassportDecoder.sol#L448)

	```solidity
	      score *= 10 ** (4 - decimals);
	```

</details>



## L-5: Event is missing `indexed` fields

Index event fields make the field more quickly accessible to off-chain tools that parse events. However, note that each index field costs extra gas during emission, so it's not necessarily best to index the maximum allowed per event (three fields). Each event should use three indexed fields if there are three or more fields, and gas usage is not particularly of concern for the events in question. If there are fewer than three fields, all of the fields should be indexed.

<details><summary>6 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 78](contracts/GitcoinPassportDecoder.sol#L78)

	```solidity
	  event EASSet(address easAddress);
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 79](contracts/GitcoinPassportDecoder.sol#L79)

	```solidity
	  event ResolverSet(address resolverAddress);
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 80](contracts/GitcoinPassportDecoder.sol#L80)

	```solidity
	  event SchemaSet(bytes32 schemaUID);
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 81](contracts/GitcoinPassportDecoder.sol#L81)

	```solidity
	  event ProvidersAdded(string[] providers);
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 83](contracts/GitcoinPassportDecoder.sol#L83)

	```solidity
	  event MaxScoreAgeSet(uint256 maxScoreAge);
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 84](contracts/GitcoinPassportDecoder.sol#L84)

	```solidity
	  event ThresholdSet(uint256 threshold);
	```

</details>



## L-6: PUSH0 is not supported by all chains

Solc compiler version 0.8.20 switches the default target EVM version to Shanghai, which means that the generated bytecode will include PUSH0 opcodes. Be sure to select the appropriate EVM version in case you intend to deploy on a chain other than mainnet like L2 chains that may not support PUSH0, otherwise deployment of your contracts will fail.

<details><summary>9 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 2](contracts/GitcoinPassportDecoder.sol#L2)

	```solidity
	pragma solidity ^0.8.9;
	```

- Found in contracts/GitcoinPassportEligibility.sol [Line: 2](contracts/GitcoinPassportEligibility.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in contracts/HatsEligibilityModule.sol [Line: 2](contracts/HatsEligibilityModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in contracts/HatsModule.sol [Line: 2](contracts/HatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in contracts/IHatsModule.sol [Line: 2](contracts/IHatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol [Line: 2](lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol#L2)

	```solidity
	pragma solidity ^0.8.9;
	```

- Found in lib/hats-module/src/HatsEligibilityModule.sol [Line: 2](lib/hats-module/src/HatsEligibilityModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in lib/hats-module/src/HatsModule.sol [Line: 2](lib/hats-module/src/HatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

- Found in lib/hats-module/src/interfaces/IHatsModule.sol [Line: 2](lib/hats-module/src/interfaces/IHatsModule.sol#L2)

	```solidity
	pragma solidity ^0.8.19;
	```

</details>



## L-7: Empty Block

Consider removing empty blocks.

<details><summary>5 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 101](contracts/GitcoinPassportDecoder.sol#L101)

	```solidity
	  function _authorizeUpgrade(address) internal override onlyOwner {
	```

- Found in contracts/HatsEligibilityModule.sol [Line: 19](contracts/HatsEligibilityModule.sol#L19)

	```solidity
	  function getWearerStatus(address _wearer, uint256 _hatId)
	```

- Found in contracts/HatsModule.sol [Line: 70](contracts/HatsModule.sol#L70)

	```solidity
	  function _setUp(bytes calldata _initData) internal virtual { }
	```

- Found in lib/hats-module/src/HatsEligibilityModule.sol [Line: 19](lib/hats-module/src/HatsEligibilityModule.sol#L19)

	```solidity
	  function getWearerStatus(address _wearer, uint256 _hatId)
	```

- Found in lib/hats-module/src/HatsModule.sol [Line: 70](lib/hats-module/src/HatsModule.sol#L70)

	```solidity
	  function _setUp(bytes calldata _initData) internal virtual { }
	```

</details>



## L-8: Unused Custom Error

it is recommended that the definition be removed when custom error is unused

<details><summary>1 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 75](contracts/GitcoinPassportDecoder.sol#L75)

	```solidity
	  error ScoreDoesNotMeetThreshold(uint256 score);
	```

</details>



