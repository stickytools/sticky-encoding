# Sticky ![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-lightgray.svg?style=flat)

<a href="https://github.com/tonystone/sticky/" target="_blank">
   <img src="https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms: iOS | macOS | watchOS | tvOS | Linux" />
</a>
<a href="https://github.com/tonystone/sticky/" target="_blank">
   <img src="https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat" alt="Swift 4.0">
</a>
<a href="https://travis-ci.org/tonystone/sticky" target="_blank">
  <img src="https://travis-ci.org/tonystone/sticky.svg?branch=master" alt="travis-ci.org" />
</a>
<a href="https://codecov.io/gh/tonystone/sticky" target="_blank">
  <img src="https://codecov.io/gh/tonystone/sticky/branch/master/graph/badge.svg" alt="Codecov" />
</a>
<a href="https://github.com/tonystone/sticky/" target="_blank">
    <img src="https://img.shields.io/cocoapods/v/Sticky.svg?style=flat" alt="Pod version">
</a>
<a href="https://github.com/tonystone/sticky/" target="_blank">
    <img src="https://img.shields.io/cocoapods/dt/Sticky.svg?style=flat" alt="Downloads">
</a>

---

**Sticky**, a collection of high performance components for persistence.  It consists of multiple modules that can either be used as a whole or individually to make up larger systems.

## Documentation

For specific documentation on each "Sticky" component see the links below:

- [**StickyCollections**](Documentation/StickyCollections.md) - Persistent collection classes backed by "StickyDB".
- [**StickyEncoding**](Documentation/StickyEncoding.md) - A high performance binary encoder for `Encodable` types.
- [**StickyDB**](Documentation/StickyDB.md) - A high performance lightweight embedable transactional database.
- [**StickyLocking**](Documentation/StickyLocking.md) - A lighweight hierarchical lock manager.

## Sources and Binaries

You can find the latest sources and binaries on [github](https://github.com/tonystone/sticky).

## Communication and Contributions

- If you **found a bug**, _and can provide steps to reliably reproduce it_, [open an issue](https://github.com/tonystone/sticky/issues).
- If you **have a feature request**, [open an issue](https://github.com/tonystone/sticky/issues).
- If you **want to contribute**
   - Fork it! [Sticky repository](https://github.com/tonystone/sticky)
   - Create your feature branch: `git checkout -b my-new-feature`
   - Commit your changes: `git commit -am 'Add some feature'`
   - Push to the branch: `git push origin my-new-feature`
   - Submit a pull request :-)

## Installation 

**Sticky** supports dependency management via Swift Package Manager on All Apple OS variants as well as Linux.

Please see [Swift Package Manager](https://swift.org/package-manager/#conceptual-overview) for further information.

## Minimum Requirements

Build Environment

| Platform | Swift | Swift Build | Xcode |
|:--------:|:-----:|:----------:|:------:|
| Linux    | 4.0 | &#x2714; | &#x2718; |
| OSX      | 4.0 | &#x2714; | Xcode 9.0 |

Minimum Runtime Version

| iOS |  OS X | tvOS | watchOS | Linux |
|:---:|:-----:|:----:|:-------:|:------------:|
| 8.0 | 10.10 | 9.0  |   2.0   | Ubuntu 14.04, 16.04, 16.10 |

> **Note:**
>
> To build and run on **Linux** we have a a preconfigure **Vagrant** file located at [https://github.com/tonystone/vagrant-swift](https://github.com/tonystone/vagrant-swift)
>
> See the [README](https://github.com/tonystone/vagrant-swift/blob/master/README.md) for instructions.
>

## Author

Tony Stone ([https://github.com/tonystone](https://github.com/tonystone))

## License

Sticky is released under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)
