# Gitcoin Passport Eligibility

Gitcoin Passport Eligibility is an eligibility module for [Hats Protocol](https://github.com/hats-protocol/hats-protocol). The module defines eligibility for wearers based on their Gitcoin Passport Score, and whether it passes a certain threshold.

## Details

GitcoinPassportEligiblity inherits from the [HatsEligibilityModule](https://github.com/Hats-Protocol/hats-module#hatseligibilitymodule) base contract from which it receives two major properties:

- It can be cheaply deployed via the minimal proxy factory[HatsModuleFactory](https://github.com/Hats-Protocol/hats-module#hatsmodulefactory)
- It implements the interface [IHatsEligibility](https://github.com/Hats-Protocol/hats-protocol/blob/main/src/Interfaces/IHatsEligibility.sol)

This eligibility module relies on the parameters and logic internal to the [GitcoinPassportDecoder.sol](https://github.com/gitcoinco/eas-proxy/blob/056a246b8c68ccdf1d16d033f1c0cd1a807cea4a/contracts/GitcoinPassportDecoder.sol) contract to determine the eligibility of a target hat.

Specifically, this module reads the user's Gitcin Passport score, and yields a boolean value based on whether said score surpasses a specified threshold. This can be useful for if an onchain organization wants to restrict the eligibility of a target hat based on some minimum Gitcoin Passport score, as a proxy for unique personhood.

The eligibility of the target hat is dynamically determined by the status of the user's Gitcoin passport. For more information, see the [official Gitcoin Passport documentation](https://docs.passport.gitcoin.co/building-with-passport/passport-api/api-reference#refreshing-scores).

Note that every time a hat with this module signs anything, this module will be called. This means that the passport score is realtime, but a hat with this module will pay more to sign a transaction than a hat without this module.

<!-- This module is simple, and relies on the protocols it bridges for its efficacy. The only configuration outside of the default is the score criterion. If the score criterion is 0, we default to Gitcoin Passport's standard criterion. 

![image](https://github.com/daocoa/gitcoin-passport-eligibility/assets/3211305/e6753cc5-c819-412d-9687-9fc5a706e139)

![image](https://github.com/daocoa/gitcoin-passport-eligibility/assets/3211305/faf155da-424b-44d2-86ed-b62148b40af2)
-->

### Setup

A GitcoinPassportEligiblity requires several parameters to be set at deployment, passed to the `HatsModuleFactory.createHatsModule()` function in various ways.

#### Immutable values

- `hatId`: The id of the hat to which this instance will be attached as an eligibility module, passed as itself
- `gitcoinPassportDecoder`: The smart contract instance of a Decoder that creates a bit map of stamp providers, which allows us to score Passports fully onchain.
- `scoreCriterion`: The threshold used to consider if an address belongs to a human. If set to 0, then the module will use Gitcoin Passport's standard criterion for the threshold. If set to a value other than 0, then the module will use the assigned value for the threshold.

## Development

This repo uses Foundry for development and testing. To get started:

1. Fork the project
2. Install [Foundry](https://book.getfoundry.sh/getting-started/installation)
3. To install dependencies, run `forge install`
4. To compile the contracts, run `forge build`
5. To test, run `forge test`

### IR-Optimized Builds

This repo also supports contracts compiled via IR. Since compiling all contracts via IR would slow down testing workflows, we only want to do this for our target contract(s), not anything in this `test` or `script` stack. We accomplish this by pre-compiled the target contract(s) and then loading the pre-compiled artifacts in the test suite.

First, we compile the target contract(s) via IR by running`FOUNDRY_PROFILE=optimized forge build` (ensuring that FOUNDRY_PROFILE is not in our .env file)

Next, ensure that tests are using the `DeployOptimized` script, and run `forge test` as normal.

See the wonderful [Seaport repo](https://github.com/ProjectOpenSea/seaport/blob/main/README.md#foundry-tests) for more details and options for this approach.

### Steps To Deploy

#### A. Simulate the deployments locally

`cd packages/foundry`

`forge script script/DeployImplementation.s.sol -f mainnet`

`forge script script/DeployInstance.s.sol -f mainnet`

#### B. Deploy to real network and verify on etherscan

`yarn deploy --network ${network_name}`

`yarn verify --network ${network_name}`

## notes

Forked from the [Hats Module Template](https://github.com/Hats-Protocol/hats-module-template).

## License

MIT
