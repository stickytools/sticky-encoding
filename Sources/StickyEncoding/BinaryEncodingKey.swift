///
///  BinaryCodingKey.swift
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
///  Created by Tony Stone on 10/16/17.
///
import Swift

///
/// Implementation of CodingKey for appending to path.  Specially useful for "super".
///
internal struct BinaryCodingKey : CodingKey {

    ///
    /// Initialize `self` to `stringValue`.
    ///
    init(_ stringValue: String) {
        self.stringValue = stringValue
    }

    // MARK: - `CodingKey` conformance.

    public var stringValue: String
    public var intValue: Int?

    public init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    public init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

///
/// `CustomStringConvertible` and `CustomDebugStringConvertible` conformance.
///
extension BinaryCodingKey: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        var string = "\"\(self.stringValue)\""
        if let intValue = intValue {
            string.append(" (\(intValue))")
        }
        return string
    }

    public var debugDescription: String {
        var string = "BinaryCodingKey(stringValue: \"\(self.stringValue)\""
        if let intValue = intValue {
            string.append(", intValue: \(intValue)")
        }
        string.append(")")
        return string
    }
}
