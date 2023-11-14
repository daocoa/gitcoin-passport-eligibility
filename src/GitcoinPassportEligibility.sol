// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

// import { console2 } from "forge-std/Test.sol"; // comment out before deploy
import { HatsEligibilityModule, HatsModule, IHatsEligibility } from "hats-module/HatsEligibilityModule.sol";
// import { IGitcoinResolver } from "eas-proxy/contracts/IGitcoinResolver.sol";
import { Attestation, IEAS } from "eas-contracts/contracts/IEAS.sol";

interface GitcoinResolverLike {
  function userAttestations(address user, bytes32 schema) external view returns (bytes32);
}

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
   * -----------------------------------------------------------------------+
   * CLONE IMMUTABLE "STORAGE"                                              |
   * -----------------------------------------------------------------------|
   * Offset  | Constant          | Type            | Length | Source        |
   * -----------------------------------------------------------------------|
   * 0       | IMPLEMENTATION    | address         | 20     | HatsModule    |
   * 20      | HATS              | address         | 20     | HatsModule    |
   * 40      | hatId             | uint256         | 32     | HatsModule    |
   * 72      | EAS               | IEAS            | 20     | this          |
   * 92      | GITCOIN_RESOLVER  | IGitcoinResolver| 20     | this          |
   * 112     | SCORE_SCHEMA      | bytes32         | 32     | this          |
   * 144     | SCORE_CRITERION   | uint256         | 32     | this          |
   * -----------------------------------------------------------------------+
   */

  /// @notice The global EAS contract
  function EAS() public pure returns (IEAS) {
    return IEAS(_getArgAddress(72));
  }

  /// @notice The Gitcoin Resolver contract
  function GITCOIN_RESOLVER() public pure returns (GitcoinResolverLike) {
    return GitcoinResolverLike(_getArgAddress(92));
  }

  /// @notice The schema for Gitcoin Passport Score attestations
  function SCORE_SCHEMA() public pure returns (bytes32) {
    return _getArgBytes32(112);
  }

  /// @notice The minimum Gitcoin Passport score required to be eligible for a hat
  function SCORE_CRITERION() public pure returns (uint256) {
    return _getArgUint256(144);
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
  function getWearerStatus(address _wearer, uint256 /*_hatId*/ )
    public
    view
    virtual
    override
    returns (bool eligible, bool standing)
  {
    // get score and decimals from the _wearer's attestation
    (uint256 score, uint8 decimals) = _getScoreAndDecimals(_wearer);

    // eligible if the score is greater than or equal to the score criterion (adjusted for decimals)
    eligible = score >= SCORE_CRITERION() * (10 ** decimals);

    // this module always returns true for standing
    standing = true;
  }

  /*//////////////////////////////////////////////////////////////
                          VIEW FUNCTIONS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Gets the Gitcoin Passport score and decimals for a given user.
   * @dev Returns with empty values (0, 0) if the user has no score, ie if:
   * - A score attestation does not exist for the user
   * - The user's score attestation has been revoked
   * - The user's score attestation has expired
   * @param _wearer The address of the user to get the score for
   * @return score The user's Gitcoin Passport score
   * @return decimals The number of decimals for the user's Gitcoin Passport score
   */
  function getScoreAndDecimals(address _wearer) external view returns (uint256 score, uint8 decimals) {
    return _getScoreAndDecimals(_wearer);
  }

  /*//////////////////////////////////////////////////////////////
                        INTERNAL FUNCTIONS
  //////////////////////////////////////////////////////////////*/

  /**
   * @dev Gets the Gitcoin Passport score and decimals for a given user.
   *  Returns with empty values (0, 0) if the user has no score, ie if:
   * - A score attestation does not exist for the user
   * - The user's score attestation has been revoked
   * - The user's score attestation has expired
   * @param _wearer The address of the user to get the score for
   * @return score The user's Gitcoin Passport score
   * @return decimals The number of decimals for the user's Gitcoin Passport score
   */
  function _getScoreAndDecimals(address _wearer) internal view returns (uint256 score, uint8 decimals) {
    // Get the attestation UID from the user's attestations
    bytes32 attestationUID = GITCOIN_RESOLVER().userAttestations(_wearer, SCORE_SCHEMA());

    // Check for existence
    if (attestationUID == 0) return (0, 0);

    // Get the attestation from the user's attestation UID
    Attestation memory attestation = EAS().getAttestation(attestationUID);
    // Check for revocation time
    if (attestation.revocationTime > 0) return (0, 0);

    // Check for expiration time
    if (attestation.expirationTime > 0 && attestation.expirationTime <= block.timestamp) {
      return (0, 0);
    }

    // Decode the attestion output to get the score and decimals
    (score,, decimals) = abi.decode(attestation.data, (uint256, uint256, uint8));
  }
}
