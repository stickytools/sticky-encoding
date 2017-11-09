//
//  BinaryCodingKeyTests.swift
//  StickyEncodingTests
//
//  Created by Tony Stone on 10/29/17.
//

import XCTest

@testable import StickyEncoding

class BinaryCodingKeyTests: XCTestCase {

    ///
    /// Test construction with a non-failable init using a `String` value.
    ///
    func testInitWithString() {
        let input = BinaryCodingKey("super")

        XCTAssertEqual(input.stringValue, "super")
        XCTAssertEqual(input.intValue, nil)
    }

    ///
    /// Test construction with a failable init using a `String` value.
    ///
    func testFailableInitWithString() {
        let input = BinaryCodingKey(stringValue: "super")

        XCTAssertEqual(input?.stringValue, "super")
        XCTAssertEqual(input?.intValue, nil)
    }

    ///
    /// Test construction with a failable init using a `Int` value.
    ///
    func testInitWithInt() {
        let input = BinaryCodingKey(intValue: 10)

        XCTAssertEqual(input?.stringValue, "10")
        XCTAssertEqual(input?.intValue, 10)
    }

    ///
    /// Test that the `description` value is correct when and `String` value is passed.
    ///
    func testDescription() {
        XCTAssertEqual(BinaryCodingKey("super").description, "\"super\"")
    }

    ///
    /// Test that the `debugDescription` value is correct when and `String` value is passed.
    ///
    func testDebugDescription() {
        XCTAssertEqual(BinaryCodingKey("super").debugDescription, "BinaryCodingKey(stringValue: \"super\")")
    }

    ///
    /// Test that the `description` value is correct when and `Int` value is passed.
    ///
    func testDescriptionWithInt() {
        XCTAssertEqual(BinaryCodingKey(intValue: 10)?.description, "\"10\" (10)")
    }

    ///
    /// Test that the `description` value is correct when and `Int` value is passed.
    ///
    func testDebugDescriptionWithInt() {
        XCTAssertEqual(BinaryCodingKey(intValue: 10)?.debugDescription, "BinaryCodingKey(stringValue: \"10\", intValue: 10)")
    }
}
