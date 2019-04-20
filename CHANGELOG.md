# Change Log
All significant changes to this project will be documented in this file.

## [1.0.0-beta.5](https://github.com/stickytools/sticky-encoding/tree/1.0.0-beta.5)

#### Removed
- Simplified the interface removing the `EncodedData` type replacing it with straight `Array<UInt8>`.

#### Added
- Changed return type of `BinaryEncoder.encode` from `EncodedData` to `Array<UInt8>`.
- Changed parameter type of `BinaryDecoder.decode` from `EncodedData` to `Array<UInt8>`.
- Moving binary conversion into decode/encode stage to improve error recovery on invalid binary input.

## [1.0.0-beta.4](https://github.com/stickytools/sticky-encoding/tree/1.0.0-beta.4)

#### Added
- Added complete documentation set available @ [https://stickytools.io/sticky-encoding](https://stickytools.io/sticky-encoding).

## [1.0.0-beta.3](https://github.com/stickytools/sticky-encoding/tree/1.0.0-beta.3)

#### Added
- Added support to/from `Swift.Data` to `EncodedData`.

#### Changed
- Changed EncodedData `var bytes: [UInt8]` to `Array<UInt8>(_ bytes: EncodedDate)` constructor.

## [1.0.0-beta.2](https://github.com/stickytools/sticky-encoding/tree/1.0.0-beta.2)

#### Added
- Added **CocoaPods** support.
- Added the ability to set a userInfo dictionary on the `BinaryEncoder` and `BinaryDecoder`.

## [1.0.0-beta.1](https://github.com/stickytools/sticky-encoding/tree/1.0.0-beta.1)

- Initial beta release of **StickyEncoding**, a high performance binary encoder for `Swift.Codable` types.
