///
///  StorageContainer+Equal.swift
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
///  Created by Tony Stone on 11/8/17.
///
///
import Swift

@testable import StickyEncoding

///
/// A special equal func for `StorageContainer` tests only.
///

internal extension StorageContainer {

    func equal(_ other: StorageContainer) -> Bool {
        guard type(of: self) == type(of: other)
            else { return false }

        switch (self, other) {
        case let keyed as (KeyedStorageContainer, KeyedStorageContainer):
            return keyed.0.equal(keyed: keyed.1)
        case let keyed as (UnkeyedStorageContainer, UnkeyedStorageContainer):
            return keyed.0.equal(unkeyed: keyed.1)
        case let keyed as (SingleValueContainer, SingleValueContainer):
            return keyed.0.equal(singleValue: keyed.1)
        default:
            break
        }
        return true
    }
}

internal extension KeyedStorageContainer {

    func equal(keyed other: KeyedStorageContainer) -> Bool {
        guard self.count == other.count
            else { return false }

        for (key, value) in self {
            if let otherValue = other[key] {
                guard value.equal(otherValue)
                    else { return false }
            }
        }
        return true
    }
}

internal extension UnkeyedStorageContainer {

    func equal(unkeyed other: UnkeyedStorageContainer) -> Bool {
        guard self.count == other.count
            else { return false }

        for i in 0..<self.count {
            guard self[i].equal(other[i])
                else { return false }
        }
        return true
    }
}

internal extension SingleValueContainer {

    func equal(singleValue other: SingleValueContainer) -> Bool {
        guard self.type == other.type && self.size == other.size
            else  { return false }

        do {
            switch self.type {
            case .bool:
                let lhValue = try self.value(as: Bool.self)
                let rhValue = try other.value(as: Bool.self)
                return lhValue == rhValue
            case .int:
                let lhValue = try self.value(as: Int.self)
                let rhValue = try other.value(as: Int.self)
                return lhValue == rhValue
            case .int8:
                let lhValue = try self.value(as: Int8.self)
                let rhValue = try other.value(as: Int8.self)
                return lhValue == rhValue
            case .int16:
                let lhValue = try self.value(as: Int16.self)
                let rhValue = try other.value(as: Int16.self)
                return lhValue == rhValue
            case .int32:
                let lhValue = try self.value(as: Int32.self)
                let rhValue = try other.value(as: Int32.self)
                return lhValue == rhValue
            case .int64:
                let lhValue = try self.value(as: Int64.self)
                let rhValue = try other.value(as: Int64.self)
                return lhValue == rhValue
            case .uint:
                let lhValue = try self.value(as: UInt.self)
                let rhValue = try other.value(as: UInt.self)
                return lhValue == rhValue
            case .uint8:
                let lhValue = try self.value(as: UInt8.self)
                let rhValue = try other.value(as: UInt8.self)
                return lhValue == rhValue
            case .uint16:
                let lhValue = try self.value(as: UInt16.self)
                let rhValue = try other.value(as: UInt16.self)
                return lhValue == rhValue
            case .uint32:
                let lhValue = try self.value(as: UInt32.self)
                let rhValue = try other.value(as: UInt32.self)
                return lhValue == rhValue
            case .uint64:
                let lhValue = try self.value(as: UInt64.self)
                let rhValue = try other.value(as: UInt64.self)
                return lhValue == rhValue
            case .float:
                let lhValue = try self.value(as: Float.self)
                let rhValue = try other.value(as: Float.self)
                return lhValue == rhValue
            case .double:
                let lhValue = try self.value(as: Double.self)
                let rhValue = try other.value(as: Double.self)
                return lhValue == rhValue
            case .string:
                let lhValue = try self.value(as: String.self)
                let rhValue = try other.value(as: String.self)
                return lhValue == rhValue
            default:
                break
            }
        } catch {}
        return false
    }
}
