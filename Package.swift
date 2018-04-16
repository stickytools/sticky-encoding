// swift-tools-version:4.0
///
/// Package.swift
///
/// Copyright (c) 2018 Tony Stone, All rights reserved.
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
/// Created by Tony Stone on 4/15/18.
///
import PackageDescription

let package = Package(
        name: "StickyEncoding",
        products: [
            .library(name: "StickyEncoding", type: .dynamic, targets: ["StickyEncoding"])
        ],
        dependencies: [
            .package(url: "https://github.com/tonystone/sticky-utilities.git", .branch("master"))
        ],
        targets: [
            /// Module targets
            .target(name: "StickyEncoding", dependencies: ["StickyUtilities"], path: "Sources/StickyEncoding"),

            /// Tests
            .testTarget(name: "StickyEncodingTests", dependencies: ["StickyEncoding"], path: "Tests/StickyEncodingTests")
        ],
        swiftLanguageVersions: [4]
)
