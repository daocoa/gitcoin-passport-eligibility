### [G-1] `GitcoinPassportEligibility::getWearerStatus` does not have the most efficient visibility type.

**Description:** `GitcoinPassportEligibility::getWearerStatus` is not called within `GitcoinPassportEligibility`, however its visibility is `public`.

**Impact:** Increases the gas cost of calling the function.

**Proof of Concept:** We can see that through fuzz testing public and external functions with the same parameters and operations, the external function resulted in costing less gas to call.

`test_externalFunction(uint256[20]) (runs: 257, μ: 255839, ~: 255839)`

`test_publicFunction(uint256[20]) (runs: 257, μ: 257286, ~: 257286)`

**Recommended Mitigation:** Change `GitcoinPassportEligibility::getWearerStatus`'s visibility from `public` to `external`.