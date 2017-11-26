///
///  NullStorageContainer.swift
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
///  Created by Tony Stone on 11/3/17.
///
///
import Swift

///
/// A class representing a Null or empty storage container.  Used as a placeholder
/// when you need to assign a value to a variable but don't have an actual value yet.
///
internal class NullStorageContainer: StorageContainer {
    private init() {}
    static var null: NullStorageContainer = NullStorageContainer()
}

///
/// `Equatable` conformance.
///
extension NullStorageContainer: Equatable {
    static func == (lhs: NullStorageContainer, rhs: NullStorageContainer) -> Bool {
        return lhs === rhs
    }
}

///
/// `CustomStringConvertible` and `CustomDebugStringConvertible` conformance.
///
extension NullStorageContainer: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String { return "null" }
    public var debugDescription: String { return "null" }
}
