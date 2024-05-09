# Gitcoin Passport Eligibility

An Hats Protocol eligibility module for Gitcoin Passport that sets a target hat's eligibility based on a given Passport score criterion.

## Overview and Usage

TODO

## Development

This repo uses Foundry for development and testing. To get started:

1. Fork the project
2. Install [Foundry](https://book.getfoundry.sh/getting-started/installation)
3. To install dependencies, run `forge install`
4. To compile the contracts, run `forge build`
5. To test, run `forge test`


## Steps To Deploy

### A. Simulate the deployments locally
`forge script script/DeployImplementation.s.sol -f mainnet`
`forge script script/DeployInstance.s.sol -f mainnet`

### B. Deploy to real network and verify on etherscan
`forge script script/DeployImplementation.s.sol mainnet --broadcast --verify`
`forge script script/DeployInstance.s.sol mainnet --broadcast --verify`

### C. Fix verification issues (replace values in curly braces with the actual values)
```
forge verify-contract --chain-id 1 --num-of-optimizations 1000000 --watch --constructor-args $(cast abi-encode \
 "constructor({args})" "{arg1}" "{arg2}" "{argN}" ) \ 
 --compiler-version v0.8.19 {deploymentAddress} \
 src/{Counter}.sol:{Counter} --etherscan-api-key $ETHERSCAN_KEY
```

## License
MIT
