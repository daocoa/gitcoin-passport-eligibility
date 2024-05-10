### [I-3] GitcoinPassportEligibility::getWearerStatus' first parameter, _wearer, does not follow the mixedCase naming convention, resulting in potential confusion from code reviewers

**Description:** The underscore naming convention is an outdated practice for function parameters. 

**Impact:** Reduces the understanding and potential interactibility of the protocol, and muddies up automated tool's results.

**Proof of Concept:** Patrick Collins, a leader security smart contract auditor and educator follows the mixedCase naming convention. Alongside automated tools like Slither and Aderyn to report instances of functions not being correctly in mixedCase. Newcomers and the majority of developers, auditors, and researchers will follow these conventions. Alongside muddying up the information that is returned from the automated tools.

**Recommended Mitigation:** Rename `GitcoinPassportEligibility::getWearerStatus`' first parameter, `_wearer`, to `wearer` to satisfy the requirement of functions being in mixedCase.