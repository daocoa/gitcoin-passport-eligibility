---
title: Gitcoin Passport Deocder Report
author: Jacob Homanics
date: May 27, 2024
header-includes:
  - \usepackage{titling}
  - \usepackage{graphicx}
---

\begin{titlepage}
\centering
\begin{figure}[h]
\centering
\includegraphics[width=0.5\textwidth]{logo.pdf}
\end{figure}
\vspace{2cm}
{\Huge\bfseries Gitcoin Passport Deocder Report\par}
\vspace{1cm}
{\Large Version 1.0\par}
\vspace{2cm}
{\Large\itshape Jacob Homanics\par}
\vfill
{\large \today\par}
\end{titlepage}

\maketitle

<!-- Your report starts here! -->

Prepared by: [Jacob Homanics](https://twitter.com/homanics)

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Protocol Summary](#protocol-summary)
- [Disclaimer](#disclaimer)
- [Risk Classification](#risk-classification)
- [Audit Details](#audit-details)
  - [Scope](#scope)
  - [Roles](#roles)
- [Executive Summary](#executive-summary)
  - [Issues found](#issues-found)
- [Findings](#findings)
- [High](#high)
- [Medium](#medium)
- [Low](#low)
- [Informational](#informational)

# Protocol Summary

GitcoinPassportDecoder is used to retrieve an addresses' Gitcoin Passport score onchain. 

# Disclaimer

Jacob Homanics makes all efforts to find as many vulnerabilities in the code in the given time period, but holds no responsibilities for the findings provided in this document. A security audit by Jacob Homanics is not an endorsement of the underlying business or product. The audit was time-boxed and the review of the code was solely on the security aspects of the Solidity implementation of the contracts.

# Risk Classification

|            |               | Impact |        |      |
| ---------- | ------------- | ------ | ------ | ---- |
|            |               | High   | Medium | Low  |
|            | High          | H      | H/M    | M    |
| Likelihood | Medium        | H/M    | M      | M/L  |
|            | Low           | M      | M/L    | L    |
|            | Informational | None   | None   | None |
|            | Gas           | None   | None   | None |

We use the [CodeHawks](https://docs.codehawks.com/hawks-auditors/how-to-evaluate-a-finding-severity) severity matrix to determine severity. See the documentation for more details.

# Audit Details

**The findings in this document correspond with the following commit hash:**
Commit Hash:

```
e347146
```

## Scope

```
GitcoinPassportDecoder.sol
```

## Roles

N/A

# Executive Summary

The file contained several noticeable vulnerabilities, however within the given context they do not seem to a major issue. However the vulnerabilities should be considered and fixed for future releases of the code.

The tools used were VSCode, Slither, and Aderyn.

## Issues found

| Severity      | Number of issues found |
| ------------- | ---------------------- |
| High          | 1                      |
| Medium        | 1                      |
| Low           | 4                      |
| Informational | 6                      |
| Gas           | 0                      |
| Total         | 12                      |

# Findings

## High

### [H-1] GitcoinPassportDecoder is not protected from being self destructed.

**Description:** GitcoinPassportDecoder is an upgradeable smart contract. This means that there is a possibility of an exploit where a hacker can call self destruct on it to remove it from the blockchain.

**Impact:** Potentially removes the current implementation from the current address which the instance resides.

**Proof of Concept:** Add a constructor to ensure initialize cannot be called on the logic contract.

```
error GitcoinPassportDecoder__CannotInitializeInLogic();
bool s_isLogicContract;

constructor() {
    s_isLogicContract = true;    
}

function initialize(...) public initializer {
    if (s_isLogicContract)
        revert GitcoinPassportDecoder__CannotInitializeInLogic();

        ...
        _;
}
```

## Medium

### [M-1] GitcoinPassportDecoder::getPassport(address).credential is never initialized.

**Description:** The local variable, credential, is never initialized. May result in undesired effects.

**Impact:** In it's current implementation, there does not seem to be a vulnerability. However, it is reccomended to follow best practices to increase code readibility and to future proof any potential changes to the data structures.

**Proof of Concept:** Initialize the credentials variable.

Change 
```
Credential memory credential;
// Set provider to the credential struct from the mappedProviders mapping
credential.provider = mappedProviders[mappedProvidersIndex];
// Set the hash to the credential struct from the hashes array
credential.hash = hashes[hashIndex];
// Set the issuanceDate of the credential struct to the item at the current index of the issuanceDates array
credential.time = issuanceDates[hashIndex];
// Set the expirationDate of the credential struct to the item at the current index of the expirationDates array
credential.expirationTime = expirationDates[hashIndex];

// Set the hashIndex with the finished credential struct
passportMemoryArray[hashIndex] = credential;

hashIndex += 1;
```

to 

```
Credential memory credential = new Credential(mappedProviders[mappedProvidersIndex], hashes[hashIndex], issuanceDates[hashIndex], expirationDates[hashIndex]);         

// Set the hashIndex with the finished credential struct
passportMemoryArray[hashIndex] = credential;

hashIndex += 1;
```

## Low

### [L-1] Centralization Risk for trusted owners

**Description:** Contracts have owners with privileged rights to perform admin tasks and need to be trusted to not perform malicious updates or drain funds.

**Impact:** <details><summary>11 Found Instances</summary>


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
	  function _authorizeUpgrade(address) internal override onlyOwner {}
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 114](contracts/GitcoinPassportDecoder.sol#L114)

	```solidity
	  function setEASAddress(address _easContractAddress) external onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 126](contracts/GitcoinPassportDecoder.sol#L126)

	```solidity
	  function setGitcoinResolver(address _gitcoinResolver) external onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 138](contracts/GitcoinPassportDecoder.sol#L138)

	```solidity
	  function setPassportSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 150](contracts/GitcoinPassportDecoder.sol#L150)

	```solidity
	  function setScoreSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 162](contracts/GitcoinPassportDecoder.sol#L162)

	```solidity
	  function setMaxScoreAge(uint64 _maxScoreAge) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 176](contracts/GitcoinPassportDecoder.sol#L176)

	```solidity
	  function setThreshold(uint256 _threshold) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 190](contracts/GitcoinPassportDecoder.sol#L190)

	```solidity
	  function addProviders(string[] memory providers) external onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 231](contracts/GitcoinPassportDecoder.sol#L231)

	```solidity
	  function createNewVersion(string[] memory providers) external onlyOwner {
	```
</details>

**Proof of Concept:** Implement AccessControl functionality to define a DEFAULT_ADMIN_ROLE and switch the appropriate functions to only being able to be called by the admin. While leaving any fund management to the owner.

### [L-2]: `public` functions not used internally could be marked `external`

**Description:** Instead of marking a function as `public`, consider marking it as `external` if it is not used internally. This will save on gas optimizations.

**Impact:** <details><summary>10 Found Instances</summary>

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

- Found in contracts/GitcoinPassportDecoder.sol [Line: 106](contracts/GitcoinPassportDecoder.sol#L106)

	```solidity
	  function getProviders(uint32 version) public view returns (string[] memory) {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 138](contracts/GitcoinPassportDecoder.sol#L138)

	```solidity
	  function setPassportSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 150](contracts/GitcoinPassportDecoder.sol#L150)

	```solidity
	  function setScoreSchemaUID(bytes32 _schemaUID) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 162](contracts/GitcoinPassportDecoder.sol#L162)

	```solidity
	  function setMaxScoreAge(uint64 _maxScoreAge) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 176](contracts/GitcoinPassportDecoder.sol#L176)

	```solidity
	  function setThreshold(uint256 _threshold) public onlyOwner {
	```

- Found in contracts/GitcoinPassportDecoder.sol [Line: 463](contracts/GitcoinPassportDecoder.sol#L463)

	```solidity
	  function isHuman(address user) public view returns (bool) {
	```

- Found in contracts/GitcoinPassportEligibility.sol [Line: 63](contracts/GitcoinPassportEligibility.sol#L63)

	```solidity
	  function getWearerStatus(address wearer, uint256 /*_hatId*/ )
	```

</details>

**Proof of Concept:** Example 1...Change `function initialize() public initializer` to `function initialize() external initializer`. 

### [L-3]: Empty Block

**Description:** There is an unused function which can be removed.



**Impact:** <details><summary>1 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 101](contracts/GitcoinPassportDecoder.sol#L101)

	```solidity
	  function _authorizeUpgrade(address) internal override onlyOwner {}
	```

</details>

**Proof of Concept:** Add functionality to the code block.


### [L-4]: Unused Custom Error

**Description:** There is an unused custom error that is taking up space.



**Impact:**

<details><summary>1 Found Instances</summary>


- Found in contracts/GitcoinPassportDecoder.sol [Line: 75](contracts/GitcoinPassportDecoder.sol#L75)

	```solidity
	  error ScoreDoesNotMeetThreshold(uint256 score);
	```

</details>

**Proof of Concept:** It is recommended that the definition be removed when custom error is unused.


## Informational

### [I-1] GitcoinPassportDecoder::setEASAddress(address)._easContractAddress parameter does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers/tools

**Description:** Variables/parameters should not start with an underscore.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of variables not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `GitcoinPassportDecoder::setEASAddress(address)._easContractAddress` to `GitcoinPassportDecoder::setEASAddress(address).easContractAddress` to satisfy the requirement of variables being in mixedCase.

### [I-2] GitcoinPassportDecoder::setGitcoinResolver(address)._gitcoinResolver parameter does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers/tools

**Description:** Variables/parameters should not start with an underscore.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of variables not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `GitcoinPassportDecoder::setGitcoinResolver(address)._gitcoinResolver` to `GitcoinPassportDecoder::setGitcoinResolver(address).gitcoinResolver` to satisfy the requirement of variables being in mixedCase.

### [I-3] GitcoinPassportDecoder::setPassportSchemaUID(bytes32)._schemaUID parameter does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers/tools

**Description:** Variables/parameters should not start with an underscore.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of variables not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `GitcoinPassportDecoder::setPassportSchemaUID(bytes32)._schemaUID` to `GitcoinPassportDecoder::setPassportSchemaUID(bytes32).schemaUID` to satisfy the requirement of variables being in mixedCase.

### [I-4] GitcoinPassportDecoder::setScoreSchemaUID(bytes32)._schemaUID parameter does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers/tools

**Description:** Variables/parameters should not start with an underscore.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of variables not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `GitcoinPassportDecoder::setScoreSchemaUID(bytes32)._schemaUID` to `GitcoinPassportDecoder::setScoreSchemaUID(bytes32).schemaUID` to satisfy the requirement of variables being in mixedCase.

### [I-5] GitcoinPassportDecoder::setMaxScoreAge(uint64)._maxScoreAge parameter does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers/tools

**Description:** Variables/parameters should not start with an underscore.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of variables not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `GitcoinPassportDecoder::setMaxScoreAge(uint64).maxScoreAge` to `GitcoinPassportDecoder::setMaxScoreAge(uint64).maxScoreAge` to satisfy the requirement of variables being in mixedCase.

### [I-6] GitcoinPassportDecoder::setThreshold(uint256)._threshold parameter does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers/tools

**Description:** Variables/parameters should not start with an underscore.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of variables not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `GitcoinPassportDecoder::setThreshold(uint256)._threshold` to `GitcoinPassportDecoder::setThreshold(uint256).threshold` to satisfy the requirement of variables being in mixedCase.