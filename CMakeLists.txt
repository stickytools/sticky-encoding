cmake_minimum_required(VERSION 3.9)

project(StickyEncoding LANGUAGES NONE)

message(STATUS "Configuring StickyEncoding for ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "")

# Git tag
set(BUILD_TOOLS_VERSION 1.2.0)

include(ExternalProject)

ExternalProject_Add(
        build-tools

        PREFIX build-tools
        #        DOWNLOAD_COMMAND ""
        #        SOURCE_DIR ../../build-tools
        GIT_REPOSITORY https://github.com/tonystone/build-tools.git
        GIT_TAG ${BUILD_TOOLS_VERSION}
        UPDATE_COMMAND ""  # Note: since there is no update step, installing the tools will only happen once even if you change the version.  To force install, remove the external/build-tools directory.
        CMAKE_CACHE_ARGS
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        EXCLUDE_FROM_ALL true
)

#
# Build tool paths.
#
set(BUILD_TOOLS_ROOT  "${CMAKE_CURRENT_BINARY_DIR}/build-tools/build-tools")
set(BUILD_TOOLS_BIN   "${BUILD_TOOLS_ROOT}/bin")

# Look for modules in the our root.
LIST(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR})

include(Gyb)

#
# Clean the package
#
add_custom_target(build-clean
        COMMAND swift package clean
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        )

#
# Build xcode project Target
#
add_custom_target(xcode-project
        DEPENDS build-tools generate-source generate-tests
        COMMAND swift package generate-xcodeproj --xcconfig-overrides Package.xcconfig --enable-code-coverage
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        SOURCES Package.swift Package.xcconfig)

add_custom_target(documentation
        DEPENDS generate-source
        COMMAND jazzy --clean
        COMMAND cp Sources/Documentation/Sections/*.png docs | true
        COMMAND cp Sources/Documentation/Abstracts/*.png docs | true
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")

add_subdirectory(Sources)
add_subdirectory(Tests)

