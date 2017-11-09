///
///  DecodingError+Extensions.swift
///
///  Copyright 2017 Tony Stone
///
///  Licensed under the Apache License, Version 2.0 (the "License");
///  you may not use this file except in compliance with the License.
///  You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///  Unless required by applicable law or agreed to in writing, software
///  distributed under the License is distributed on an "AS IS" BASIS,
///  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  See the License for the specific language governing permissions and
///  limitations under the License.
///
///  Created by Tony Stone on 11/2/17.
///
///
import Swift

///
/// Extension encapsulating error messages and the context for `DecodingError`s.
///
internal
extension DecodingError {

    // MARK: - `DecodingError.keyNotFound` errors.

    internal /* @testable */
    static func keyNotFoundError(at path: [CodingKey], forKey key: CodingKey) -> DecodingError {
        let context = DecodingError.Context(codingPath: path, debugDescription: "No value associated with key \"\(key)\".")

        return .keyNotFound(key, context)
    }

    // MARK: - `DecodingError.typeMismatch` errors.

    internal
    static func typeMismatchError<E,A>(at path: [CodingKey], expected: E.Type, actual: A) -> DecodingError {
        let description = "Expected to decode \(expected) but found \(_actualDescription(of: actual)) instead."
        return .typeMismatch(expected, Context(codingPath: path, debugDescription: description))
    }

    internal
    static func typeMismatchError<E>(at path: [CodingKey], expected: E.Type, actual: EncodedType) -> DecodingError {
        let description = "Expected to decode \(expected) but found \(actual) instead."
        return .typeMismatch(expected, Context(codingPath: path, debugDescription: description))
    }

    // MARK: - `DecodingError.valueNotFound` errors.

    internal
    static func valueNotFoundError<E>(at path: [CodingKey], expected: E.Type, isAtEnd: Bool = false) -> DecodingError {
        let description: String
        if isAtEnd {
            description = "Unkeyed container is at end."
        } else {
            description = "Expected \(expected) value but found null instead."
        }
        return .valueNotFound(expected, DecodingError.Context(codingPath: path, debugDescription: description))
    }

    // MARK: - Private helper methods

    private static func _actualDescription<T>(of value: T) -> String {
        if value is NullStorageContainer {
            return "a null value"
        } else if value is UnkeyedStorageContainer {
            return "UnkeyedDecodingContainer"
        } else if value is KeyedStorageContainer {
            return "KeyedDecodingContainer<CodingKeys>"
        } else if value is SingleValueContainer {
            return "SingleValueDecodingContainer"
        } else {
            return String(describing: type(of: value))
        }
    }
}
