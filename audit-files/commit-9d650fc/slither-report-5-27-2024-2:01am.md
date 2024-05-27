Summary
 - [unprotected-upgrade](#unprotected-upgrade) (1 results) (High)
 - [uninitialized-local](#uninitialized-local) (1 results) (Medium)
 - [unused-return](#unused-return) (2 results) (Medium)
 - [timestamp](#timestamp) (3 results) (Low)
 - [assembly](#assembly) (52 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [dead-code](#dead-code) (1 results) (Informational)
 - [solc-version](#solc-version) (8 results) (Informational)
 - [low-level-calls](#low-level-calls) (8 results) (Informational)
 - [naming-convention](#naming-convention) (20 results) (Informational)
## unprotected-upgrade
Impact: High
Confidence: High
 - [ ] ID-0
[GitcoinPassportDecoder](contracts/GitcoinPassportDecoder.sol#L17-L468) is an upgradeable contract that does not protect its initialize functions: [GitcoinPassportDecoder.initialize()](contracts/GitcoinPassportDecoder.sol#L86-L91). Anyone can delete the contract with: [UUPSUpgradeable.upgradeToAndCall(address,bytes)](lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L86-L89)
contracts/GitcoinPassportDecoder.sol#L17-L468


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-1
[GitcoinPassportDecoder.getPassport(address).credential](contracts/GitcoinPassportDecoder.sol#L339) is a local variable never initialized

contracts/GitcoinPassportDecoder.sol#L339


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-2
[ERC1967Utils.upgradeToAndCall(address,bytes)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L83-L92) ignores return value by [Address.functionDelegateCall(newImplementation,data)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L88)

lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L83-L92


 - [ ] ID-3
[ERC1967Utils.upgradeBeaconToAndCall(address,bytes)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L173-L182) ignores return value by [Address.functionDelegateCall(IBeacon(newBeacon).implementation(),data)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L178)

lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L173-L182


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-4
[GitcoinPassportDecoder.getPassport(address)](contracts/GitcoinPassportDecoder.sol#L253-L367) uses timestamp for comparisons
        Dangerous comparisons:
        - [attestation.expirationTime > 0 && attestation.expirationTime <= block.timestamp](contracts/GitcoinPassportDecoder.sol#L272-L273)

contracts/GitcoinPassportDecoder.sol#L253-L367


 - [ ] ID-5
[GitcoinPassportDecoder._isCachedScoreExpired(IGitcoinResolver.CachedScore)](contracts/GitcoinPassportDecoder.sol#L392-L400) uses timestamp for comparisons
        Dangerous comparisons:
        - [block.timestamp > score.expirationTime](contracts/GitcoinPassportDecoder.sol#L397)
        - [(block.timestamp > score.time + maxScoreAge)](contracts/GitcoinPassportDecoder.sol#L399)

contracts/GitcoinPassportDecoder.sol#L392-L400


 - [ ] ID-6
[GitcoinPassportDecoder._isScoreAttestationExpired(Attestation)](contracts/GitcoinPassportDecoder.sol#L376-L384) uses timestamp for comparisons
        Dangerous comparisons:
        - [block.timestamp > attestation.expirationTime](contracts/GitcoinPassportDecoder.sol#L380)
        - [block.timestamp > attestation.time + maxScoreAge](contracts/GitcoinPassportDecoder.sol#L383)

contracts/GitcoinPassportDecoder.sol#L376-L384


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-7
[Clone._getArgUint248(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L102-L108) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L105-L107)

lib/hats-module/lib/solady/src/utils/Clone.sol#L102-L108


 - [ ] ID-8
[Clone._getArgUint176(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L183-L189) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L186-L188)

lib/hats-module/lib/solady/src/utils/Clone.sol#L183-L189


 - [ ] ID-9
[Clone._getArgUint216(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L138-L144) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L141-L143)

lib/hats-module/lib/solady/src/utils/Clone.sol#L138-L144


 - [ ] ID-10
[Clone._getArgUint8(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L372-L378) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L375-L377)

lib/hats-module/lib/solady/src/utils/Clone.sol#L372-L378


 - [ ] ID-11
[Clone._getArgUint112(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L255-L261) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L258-L260)

lib/hats-module/lib/solady/src/utils/Clone.sol#L255-L261


 - [ ] ID-12
[Clone._getArgUint32(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L345-L351) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L348-L350)

lib/hats-module/lib/solady/src/utils/Clone.sol#L345-L351


 - [ ] ID-13
[StorageSlot.getBytesSlot(bytes)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L129-L134) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L131-L133)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L129-L134


 - [ ] ID-14
[Clone._getArgBytes(uint256,uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L25-L40) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L32-L39)

lib/hats-module/lib/solady/src/utils/Clone.sol#L25-L40


 - [ ] ID-15
[Clone._getArgBytes32(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L84-L90) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L87-L89)

lib/hats-module/lib/solady/src/utils/Clone.sol#L84-L90


 - [ ] ID-16
[Clone._getArgUint160(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L201-L207) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L204-L206)

lib/hats-module/lib/solady/src/utils/Clone.sol#L201-L207


 - [ ] ID-17
[Address._revert(bytes,string)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L231-L243) uses assembly
        - [INLINE ASM](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L236-L239)

lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L231-L243


 - [ ] ID-18
[Clone._getArgBytes32Array(uint256,uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L68-L81) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L75-L80)

lib/hats-module/lib/solady/src/utils/Clone.sol#L68-L81


 - [ ] ID-19
[Clone._getArgUint168(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L192-L198) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L195-L197)

lib/hats-module/lib/solady/src/utils/Clone.sol#L192-L198


 - [ ] ID-20
[Clone._getArgUint144(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L219-L225) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L222-L224)

lib/hats-module/lib/solady/src/utils/Clone.sol#L219-L225


 - [ ] ID-21
[Clone._getArgUint88(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L282-L288) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L285-L287)

lib/hats-module/lib/solady/src/utils/Clone.sol#L282-L288


 - [ ] ID-22
[Clone._getArgUint192(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L165-L171) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L168-L170)

lib/hats-module/lib/solady/src/utils/Clone.sol#L165-L171


 - [ ] ID-23
[StorageSlot.getStringSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L99-L104) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L101-L103)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L99-L104


 - [ ] ID-24
[OwnableUpgradeable._getOwnableStorage()](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L30-L34) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L31-L33)

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L30-L34


 - [ ] ID-25
[StorageSlot.getBooleanSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L69-L74) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L71-L73)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L69-L74


 - [ ] ID-26
[Clone._getArgAddress(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L43-L49) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L46-L48)

lib/hats-module/lib/solady/src/utils/Clone.sol#L43-L49


 - [ ] ID-27
[Clone._getArgUint64(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L309-L315) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L312-L314)

lib/hats-module/lib/solady/src/utils/Clone.sol#L309-L315


 - [ ] ID-28
[Clone._getArgUint200(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L156-L162) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L159-L161)

lib/hats-module/lib/solady/src/utils/Clone.sol#L156-L162


 - [ ] ID-29
[Clone._getArgUint96(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L273-L279) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L276-L278)

lib/hats-module/lib/solady/src/utils/Clone.sol#L273-L279


 - [ ] ID-30
[Clone._getArgUint128(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L237-L243) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L240-L242)

lib/hats-module/lib/solady/src/utils/Clone.sol#L237-L243


 - [ ] ID-31
[Clone._getArgUint232(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L120-L126) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L123-L125)

lib/hats-module/lib/solady/src/utils/Clone.sol#L120-L126


 - [ ] ID-32
[Clone._getArgUint56(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L318-L324) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L321-L323)

lib/hats-module/lib/solady/src/utils/Clone.sol#L318-L324


 - [ ] ID-33
[StorageSlot.getStringSlot(string)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L109-L114) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L111-L113)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L109-L114


 - [ ] ID-34
[Clone._getArgUint184(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L174-L180) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L177-L179)

lib/hats-module/lib/solady/src/utils/Clone.sol#L174-L180


 - [ ] ID-35
[Clone._getArgUint40(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L336-L342) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L339-L341)

lib/hats-module/lib/solady/src/utils/Clone.sol#L336-L342


 - [ ] ID-36
[PausableUpgradeable._getPausableStorage()](lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L27-L31) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L28-L30)

lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L27-L31


 - [ ] ID-37
[Clone._getArgUint208(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L147-L153) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L150-L152)

lib/hats-module/lib/solady/src/utils/Clone.sol#L147-L153


 - [ ] ID-38
[Clone._getArgUint48(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L327-L333) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L330-L332)

lib/hats-module/lib/solady/src/utils/Clone.sol#L327-L333


 - [ ] ID-39
[Initializable._getInitializableStorage()](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L223-L227) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L224-L226)

lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L223-L227


 - [ ] ID-40
[Clone._getArgUint256Array(uint256,uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L52-L65) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L59-L64)

lib/hats-module/lib/solady/src/utils/Clone.sol#L52-L65


 - [ ] ID-41
[Clone._getArgUint72(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L300-L306) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L303-L305)

lib/hats-module/lib/solady/src/utils/Clone.sol#L300-L306


 - [ ] ID-42
[Clone._getArgUint16(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L363-L369) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L366-L368)

lib/hats-module/lib/solady/src/utils/Clone.sol#L363-L369


 - [ ] ID-43
[Clone._getArgUint152(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L210-L216) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L213-L215)

lib/hats-module/lib/solady/src/utils/Clone.sol#L210-L216


 - [ ] ID-44
[Address._revert(bytes)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L146-L158) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/Address.sol#L151-L154)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L146-L158


 - [ ] ID-45
[Clone._getArgBytes()](lib/hats-module/lib/solady/src/utils/Clone.sol#L10-L22) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L13-L21)

lib/hats-module/lib/solady/src/utils/Clone.sol#L10-L22


 - [ ] ID-46
[StorageSlot.getUint256Slot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L89-L94) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L91-L93)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L89-L94


 - [ ] ID-47
[Clone._getArgUint80(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L291-L297) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L294-L296)

lib/hats-module/lib/solady/src/utils/Clone.sol#L291-L297


 - [ ] ID-48
[StorageSlot.getBytesSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L119-L124) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L121-L123)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L119-L124


 - [ ] ID-49
[Clone._getArgUint256(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L93-L99) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L96-L98)

lib/hats-module/lib/solady/src/utils/Clone.sol#L93-L99


 - [ ] ID-50
[Clone._getImmutableArgsOffset()](lib/hats-module/lib/solady/src/utils/Clone.sol#L381-L386) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L383-L385)

lib/hats-module/lib/solady/src/utils/Clone.sol#L381-L386


 - [ ] ID-51
[Clone._getArgUint136(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L228-L234) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L231-L233)

lib/hats-module/lib/solady/src/utils/Clone.sol#L228-L234


 - [ ] ID-52
[Clone._getArgUint224(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L129-L135) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L132-L134)

lib/hats-module/lib/solady/src/utils/Clone.sol#L129-L135


 - [ ] ID-53
[StorageSlot.getAddressSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L59-L64) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L61-L63)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L59-L64


 - [ ] ID-54
[Clone._getArgUint24(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L354-L360) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L357-L359)

lib/hats-module/lib/solady/src/utils/Clone.sol#L354-L360


 - [ ] ID-55
[StorageSlot.getBytes32Slot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L79-L84) uses assembly
        - [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L81-L83)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L79-L84


 - [ ] ID-56
[Clone._getArgUint240(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L111-L117) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L114-L116)

lib/hats-module/lib/solady/src/utils/Clone.sol#L111-L117


 - [ ] ID-57
[Clone._getArgUint120(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L246-L252) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L249-L251)

lib/hats-module/lib/solady/src/utils/Clone.sol#L246-L252


 - [ ] ID-58
[Clone._getArgUint104(uint256)](lib/hats-module/lib/solady/src/utils/Clone.sol#L264-L270) uses assembly
        - [INLINE ASM](lib/hats-module/lib/solady/src/utils/Clone.sol#L267-L269)

lib/hats-module/lib/solady/src/utils/Clone.sol#L264-L270


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-59
8 different versions of Solidity are used:
        - Version constraint ^0.8.9 is used by:
                - contracts/GitcoinPassportDecoder.sol#2
                - lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol#2
                - lib/eas-proxy/contracts/IGitcoinResolver.sol#2
        - Version constraint ^0.8.19 is used by:
                - contracts/GitcoinPassportEligibility.sol#2
                - contracts/HatsEligibilityModule.sol#2
                - contracts/HatsModule.sol#2
                - contracts/IHatsModule.sol#2
                - lib/hats-module/src/HatsEligibilityModule.sol#2
                - lib/hats-module/src/HatsModule.sol#2
                - lib/hats-module/src/interfaces/IHatsModule.sol#2
        - Version constraint ^0.8.0 is used by:
                - lib/eas-contracts/contracts/Common.sol#3
                - lib/eas-contracts/contracts/IEAS.sol#3
                - lib/eas-contracts/contracts/ISchemaRegistry.sol#3
                - lib/eas-contracts/contracts/ISemver.sol#3
                - lib/eas-contracts/contracts/resolver/ISchemaResolver.sol#3
        - Version constraint >=0.8.13 is used by:
                - lib/hats-module/lib/hats-protocol/src/Interfaces/HatsErrors.sol#17
                - lib/hats-module/lib/hats-protocol/src/Interfaces/HatsEvents.sol#17
                - lib/hats-module/lib/hats-protocol/src/Interfaces/IHats.sol#17
                - lib/hats-module/lib/hats-protocol/src/Interfaces/IHatsEligibility.sol#17
                - lib/hats-module/lib/hats-protocol/src/Interfaces/IHatsIdUtilities.sol#17
        - Version constraint ^0.8.2 is used by:
                - lib/hats-module/lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#4
        - Version constraint ^0.8.1 is used by:
                - lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#4
        - Version constraint ^0.8.4 is used by:
                - lib/hats-module/lib/solady/src/utils/Clone.sol#2
        - Version constraint ^0.8.20 is used by:
                - lib/openzeppelin-contracts/contracts/interfaces/draft-IERC1822.sol#4
                - lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#4
                - lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#4
                - lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#4
                - lib/openzeppelin-contracts/contracts/utils/Address.sol#4
                - lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#5
                - lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#4
                - lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#4
                - lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#4
                - lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#4

## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-60
[uncheckedInc(uint256)](lib/eas-contracts/contracts/Common.sol#L40-L44) is never used and should be removed

lib/eas-contracts/contracts/Common.sol#L40-L44


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-61
Version constraint ^0.8.9 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - VerbatimInvalidDeduplication
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - DataLocationChangeInInternalOverride
        - NestedCalldataArrayAbiReencodingSizeValidation.
 It is used by:
        - contracts/GitcoinPassportDecoder.sol#2
        - lib/eas-proxy/contracts/IGitcoinPassportDecoder.sol#2
        - lib/eas-proxy/contracts/IGitcoinResolver.sol#2

 - [ ] ID-62
Version constraint ^0.8.1 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - DataLocationChangeInInternalOverride
        - NestedCalldataArrayAbiReencodingSizeValidation
        - SignedImmutables
        - ABIDecodeTwoDimensionalArrayMemory
        - KeccakCaching.
 It is used by:
        - lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#4

 - [ ] ID-63
Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - VerbatimInvalidDeduplication
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess.
 It is used by:
        - lib/openzeppelin-contracts/contracts/interfaces/draft-IERC1822.sol#4
        - lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#4
        - lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#4
        - lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#4
        - lib/openzeppelin-contracts/contracts/utils/Address.sol#4
        - lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#5
        - lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#4
        - lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#4
        - lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#4
        - lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#4

 - [ ] ID-64
Version constraint ^0.8.0 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - DataLocationChangeInInternalOverride
        - NestedCalldataArrayAbiReencodingSizeValidation
        - SignedImmutables
        - ABIDecodeTwoDimensionalArrayMemory
        - KeccakCaching.
 It is used by:
        - lib/eas-contracts/contracts/Common.sol#3
        - lib/eas-contracts/contracts/IEAS.sol#3
        - lib/eas-contracts/contracts/ISchemaRegistry.sol#3
        - lib/eas-contracts/contracts/ISemver.sol#3
        - lib/eas-contracts/contracts/resolver/ISchemaResolver.sol#3

 - [ ] ID-65
Version constraint ^0.8.19 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - VerbatimInvalidDeduplication
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess.
 It is used by:
        - contracts/GitcoinPassportEligibility.sol#2
        - contracts/HatsEligibilityModule.sol#2
        - contracts/HatsModule.sol#2
        - contracts/IHatsModule.sol#2
        - lib/hats-module/src/HatsEligibilityModule.sol#2
        - lib/hats-module/src/HatsModule.sol#2
        - lib/hats-module/src/interfaces/IHatsModule.sol#2

 - [ ] ID-66
Version constraint ^0.8.4 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - DataLocationChangeInInternalOverride
        - NestedCalldataArrayAbiReencodingSizeValidation
        - SignedImmutables.
 It is used by:
        - lib/hats-module/lib/solady/src/utils/Clone.sol#2

 - [ ] ID-67
Version constraint >=0.8.13 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - VerbatimInvalidDeduplication
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess
        - StorageWriteRemovalBeforeConditionalTermination
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - InlineAssemblyMemorySideEffects
        - DataLocationChangeInInternalOverride
        - NestedCalldataArrayAbiReencodingSizeValidation.
 It is used by:
        - lib/hats-module/lib/hats-protocol/src/Interfaces/HatsErrors.sol#17
        - lib/hats-module/lib/hats-protocol/src/Interfaces/HatsEvents.sol#17
        - lib/hats-module/lib/hats-protocol/src/Interfaces/IHats.sol#17
        - lib/hats-module/lib/hats-protocol/src/Interfaces/IHatsEligibility.sol#17
        - lib/hats-module/lib/hats-protocol/src/Interfaces/IHatsIdUtilities.sol#17

 - [ ] ID-68
Version constraint ^0.8.2 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - DataLocationChangeInInternalOverride
        - NestedCalldataArrayAbiReencodingSizeValidation
        - SignedImmutables
        - ABIDecodeTwoDimensionalArrayMemory
        - KeccakCaching.
 It is used by:
        - lib/hats-module/lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#4

## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-69
Low level call in [Address.functionStaticCall(address,bytes,string)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L155-L162):
        - [(success,returndata) = target.staticcall(data)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L160)

lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L155-L162


 - [ ] ID-70
Low level call in [Address.functionDelegateCall(address,bytes,string)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L180-L187):
        - [(success,returndata) = target.delegatecall(data)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L185)

lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L180-L187


 - [ ] ID-71
Low level call in [Address.sendValue(address,uint256)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L64-L69):
        - [(success,None) = recipient.call{value: amount}()](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L67)

lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L64-L69


 - [ ] ID-72
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L128-L137):
        - [(success,returndata) = target.call{value: value}(data)](lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L135)

lib/hats-module/lib/openzeppelin-contracts/contracts/utils/Address.sol#L128-L137


 - [ ] ID-73
Low level call in [Address.functionStaticCall(address,bytes)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L95-L98):
        - [(success,returndata) = target.staticcall(data)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L96)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L95-L98


 - [ ] ID-74
Low level call in [Address.functionDelegateCall(address,bytes)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L104-L107):
        - [(success,returndata) = target.delegatecall(data)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L105)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L104-L107


 - [ ] ID-75
Low level call in [Address.sendValue(address,uint256)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L41-L50):
        - [(success,None) = recipient.call{value: amount}()](lib/openzeppelin-contracts/contracts/utils/Address.sol#L46)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L41-L50


 - [ ] ID-76
Low level call in [Address.functionCallWithValue(address,bytes,uint256)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L83-L89):
        - [(success,returndata) = target.call{value: value}(data)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L87)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L83-L89


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-77
Function [HatsModule.HATS()](contracts/HatsModule.sol#L43-L45) is not in mixedCase

contracts/HatsModule.sol#L43-L45


 - [ ] ID-78
Function [IHatsModule.HATS()](contracts/IHatsModule.sol#L8) is not in mixedCase

contracts/IHatsModule.sol#L8


 - [ ] ID-79
Constant [OwnableUpgradeable.OwnableStorageLocation](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L28) is not in UPPER_CASE_WITH_UNDERSCORES

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L28


 - [ ] ID-80
Parameter [GitcoinPassportDecoder.setThreshold(uint256)._threshold](contracts/GitcoinPassportDecoder.sol#L177) is not in mixedCase

contracts/GitcoinPassportDecoder.sol#L177


 - [ ] ID-81
Function [OwnableUpgradeable.__Ownable_init(address)](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L51-L53) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L51-L53


 - [ ] ID-82
Parameter [GitcoinPassportDecoder.setScoreSchemaUID(bytes32)._schemaUID](contracts/GitcoinPassportDecoder.sol#L151) is not in mixedCase

contracts/GitcoinPassportDecoder.sol#L151


 - [ ] ID-83
Function [OwnableUpgradeable.__Ownable_init_unchained(address)](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L55-L60) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L55-L60


 - [ ] ID-84
Function [HatsModule.IMPLEMENTATION()](contracts/HatsModule.sol#L38-L40) is not in mixedCase

contracts/HatsModule.sol#L38-L40


 - [ ] ID-85
Function [ContextUpgradeable.__Context_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22


 - [ ] ID-86
Parameter [GitcoinPassportDecoder.setGitcoinResolver(address)._gitcoinResolver](contracts/GitcoinPassportDecoder.sol#L127) is not in mixedCase

contracts/GitcoinPassportDecoder.sol#L127


 - [ ] ID-87
Parameter [HatsModule.setUp(bytes)._initData](contracts/HatsModule.sol#L65) is not in mixedCase

contracts/HatsModule.sol#L65


 - [ ] ID-88
Parameter [GitcoinPassportDecoder.setEASAddress(address)._easContractAddress](contracts/GitcoinPassportDecoder.sol#L115) is not in mixedCase

contracts/GitcoinPassportDecoder.sol#L115


 - [ ] ID-89
Variable [UUPSUpgradeable.__self](lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L21) is not in mixedCase

lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L21


 - [ ] ID-90
Function [IHatsModule.IMPLEMENTATION()](contracts/IHatsModule.sol#L11) is not in mixedCase

contracts/IHatsModule.sol#L11


 - [ ] ID-91
Parameter [GitcoinPassportDecoder.setMaxScoreAge(uint64)._maxScoreAge](contracts/GitcoinPassportDecoder.sol#L163) is not in mixedCase

contracts/GitcoinPassportDecoder.sol#L163


 - [ ] ID-92
Function [PausableUpgradeable.__Pausable_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L56-L58) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L56-L58


 - [ ] ID-93
Function [ContextUpgradeable.__Context_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19


 - [ ] ID-94
Constant [PausableUpgradeable.PausableStorageLocation](lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L25) is not in UPPER_CASE_WITH_UNDERSCORES

lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L25


 - [ ] ID-95
Parameter [GitcoinPassportDecoder.setPassportSchemaUID(bytes32)._schemaUID](contracts/GitcoinPassportDecoder.sol#L139) is not in mixedCase

contracts/GitcoinPassportDecoder.sol#L139


 - [ ] ID-96
Function [PausableUpgradeable.__Pausable_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L60-L63) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol#L60-L63