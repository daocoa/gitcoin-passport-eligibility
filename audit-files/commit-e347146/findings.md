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




