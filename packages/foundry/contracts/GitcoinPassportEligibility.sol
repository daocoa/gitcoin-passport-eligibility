// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// import { console2 } from "forge-std/Test.sol"; // comment out before deploy
import { HatsEligibilityModule, HatsModule, IHatsEligibility } from "../lib/hats-module/src/HatsEligibilityModule.sol";
import { IGitcoinPassportDecoder } from "../lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol";

contract GitcoinPassportEligibility is HatsEligibilityModule {
  /*//////////////////////////////////////////////////////////////
                            CONSTANTS 
  //////////////////////////////////////////////////////////////*/

  /**
   * This contract is a clone with immutable args, which means that it is deployed with a set of
   * immutable storage variables (ie constants). Accessing these constants is cheaper than accessing
   * regular storage variables (such as those set on initialization of a typical EIP-1167 clone),
   * but requires a slightly different approach since they are read from calldata instead of storage.
   *
   * Below is a table of constants and their location.
   *
   * For more, see here: https://github.com/Saw-mon-and-Natalie/clones-with-immutable-args
   *
   * ------------------------------------------------------------------------------+
   * CLONE IMMUTABLE "STORAGE"                                                     |
   * ------------------------------------------------------------------------------|
   * Offset  | Constant                 | Type            | Length | Source        |
   * ------------------------------------------------------------------------------|
   * 0       | IMPLEMENTATION           | address         | 20     | HatsModule    |
   * 20      | HATS                     | address         | 20     | HatsModule    |
   * 40      | hatId                    | uint256         | 32     | HatsModule    |
   * 72      | gitcoinPassportDecoder   | address         | 20     | this          |
   * 92      | scoreCriterion           | uint256         | 32     | this          |
   * ------------------------------------------------------------------------------+
   */

  /// @notice The Gitcoin Resolver contract
  function gitcoinPassportDecoder() public pure returns (IGitcoinPassportDecoder) {
    return IGitcoinPassportDecoder(_getArgAddress(72));
  }

  /// @notice The minimum Gitcoin Passport score required to be eligible for a hat, with 4 decimal places
  function scoreCriterion() public pure returns (uint256) {
    return _getArgUint256(92) * 10 ** 4;
  }

  /*//////////////////////////////////////////////////////////////
                            MUTABLE STATE
  //////////////////////////////////////////////////////////////*/

  /*//////////////////////////////////////////////////////////////
                            CONSTRUCTOR
  //////////////////////////////////////////////////////////////*/

  /// @notice Deploy the implementation contract and set its version
  /// @dev This is only used to deploy the implementation contract, and should not be used to deploy clones
  constructor(string memory _version) HatsModule(_version) { }

  /*//////////////////////////////////////////////////////////////
                    HATS ELIGIBILITY FUNCTION
  //////////////////////////////////////////////////////////////*/

  /// @inheritdoc IHatsEligibility
  function getWearerStatus(address wearer, uint256 /*_hatId*/ )
    public
    view
    virtual
    override
    returns (bool eligible, bool standing)
  {
    // eligible if the wearer has a score greater than or equal to the score criterion
    eligible = isHuman(wearer);

    // this module always returns true for standing
    standing = true;
  }

  /*//////////////////////////////////////////////////////////////
                          VIEW FUNCTIONS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Assesses whether a user is human based on their Gitcoin Passport score
   * @dev Returns
   * - A score attestation does not exist for the user
   * - The user's score attestation has been revoked
   * - The user's score attestation has expired
   * @param wearer The address of the user to get the score for
   * @return Whether the user is human in compliance with the score criterion
   */
  function isHuman(address wearer) public view returns (bool) {
    uint256 _scoreCriterion = scoreCriterion();
    IGitcoinPassportDecoder _gitcoinPassportDecoder = gitcoinPassportDecoder();
    // we use a try/catch to handle cases where the user...
    //    - doesn't have a score attestation,
    //    - the attestation has been revoked, or
    //    - the attestation has expired
    if (_scoreCriterion == 0) {
      // if our score criterion is 0, we default to Gitcoin Passport's standard criterion
      try _gitcoinPassportDecoder.isHuman(wearer) returns (bool result) {
        return result;
      } catch {
        return false;
      }
    } else {
      // otherwise, we use our score criterion
      try _gitcoinPassportDecoder.getScore(wearer) returns (uint256 score) {
        return score >= _scoreCriterion;
      } catch {
        return false;
      }
    }
  }
}
