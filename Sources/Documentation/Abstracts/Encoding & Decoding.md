StickyEncoding facilitates the encoding and decoding of `Codable` values into and out of a binary
format that can be stored on disk or sent over a socket.

Encoding is done using a `BinaryEncoder` instance and will encode any `Encodable` type whether you declare conformance to `Encodable` and let the compiler create the code, or you manually implement the conformance yourself.

Decoding is done using a `BinaryDecoder` instance and can decode any `Decodable` type that was previously encoded using the `BinaryEncoder`. Of course you can declare `Encodable` or `Decodable` conformance by using `Codable` as well.

StickyEncoding creates a compact binary format that represents the encoded object or data type.  You can read more about the format in the document [Binary Format](Sources/Documentation/Sections/Binary&#32;Format.md).
