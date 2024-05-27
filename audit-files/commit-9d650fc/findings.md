### [I-1] HatsModule::IMPLEMENTATION function does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers

**Description:** All caps naming convention is reserved for constant variables. Although `HatsModule::IMPLEMENTATION` returns an immutable constant value, it is still a function. Thus it should follow the mixedCase naming convention.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results..

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of functions not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `HatsModule::IMPLEMENTATION` to `HatsModule::getImplementation` to satisfy the requirement of functions being in mixedCase.

### [I-2] HatsModule::HATS function does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers

**Description:** All caps naming convention is reserved for constant variables. Although `HatsModule::HATS` returns an immutable constant value, it is still a function. Thus it should follow the mixedCase naming convention.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results..

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of functions not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `HatsModule::HATS` to `HatsModule::getHats` to satisfy the requirement of functions being in mixedCase.

### [I-3] HatsModule::setUp(bytes)._initData variable does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers

**Description:** Underscores should not be used in to start variable names.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of functions not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `HatsModule::setUp(bytes)._initData` to `HatsModule::setUp(bytes).initData` to satisfy the requirement of functions being in mixedCase.

### [I-4] IHatsModule::IMPLEMENTATION function does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers

**Description:** All caps naming convention is reserved for constant variables. Although `IHatsModule::IMPLEMENTATION` returns an immutable constant value, it is still a function. Thus it should follow the mixedCase naming convention.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results..

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of functions not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `IHatsModule::IMPLEMENTATION` to `IHatsModule::getImplementation` to satisfy the requirement of functions being in mixedCase.

### [I-5] IHatsModule::HATS function does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers

**Description:** All caps naming convention is reserved for constant variables. Although `IHatsModule::HATS` returns an immutable constant value, it is still a function. Thus it should follow the mixedCase naming convention.

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results..

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of functions not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `IHatsModule::HATS` to `IHatsModule::getHats` to satisfy the requirement of functions being in mixedCase.