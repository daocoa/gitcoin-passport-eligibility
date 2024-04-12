# Gitcoin Passport Eligibility

An Hats Protocol eligibility module for Gitcoin Passport that sets a target hat's eligibility based on a given Passport score criterion.

## Overview and Usage

This eligibility module relies on the parameters and logic internal to the [GitcoinPassportDecoder.sol](https://github.com/gitcoinco/eas-proxy/blob/056a246b8c68ccdf1d16d033f1c0cd1a807cea4a/contracts/GitcoinPassportDecoder.sol) contract to determine the eligibility of a target hat.

Specifically, this module reads the user's Gitcin Passport score, and yields a boolean value based on whether said score surpasses a specified threshold. This can be useful for if an onchain organization wants to restrict the eligibility of a target hat based on some minimum Gitcoin Passport sscore, as a proxy for unique personhood.

The eligibility of the target hat is dynamically determined by the status of the user's Gitcoin passport. For more information, see the [official Gitcoin Passport documentation](https://docs.passport.gitcoin.co/building-with-passport/passport-api/api-reference#refreshing-scores).

## Development

This repo uses Foundry for development and testing. To get started:

1. Fork the project
2. Install [Foundry](https://book.getfoundry.sh/getting-started/installation)
3. To install dependencies, run `forge install`
4. To compile the contracts, run `forge build`
5. To test, run `forge test`

## License

TBD
