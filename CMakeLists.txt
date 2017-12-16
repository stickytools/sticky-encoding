cmake_minimum_required(VERSION 3.9)

project(Sticky LANGUAGES NONE)

message(STATUS "Configuring Sticky for ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "")

# Git tag hash == 1.0.0
set(BUILD_TOOLS_VERSION 1.0.0)

include(ExternalProject)

ExternalProject_Add(
        build-tools

        PREFIX external
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
set(BUILD_TOOLS_BIN  "${CMAKE_CURRENT_BINARY_DIR}/external/build-tools/bin")
set(GYBTOOL       "${BUILD_TOOLS_BIN}/gyb")
set(LINUXMAINTOOL "${BUILD_TOOLS_BIN}/generate_xctest_runner.rb")

#
#
# Internal functions
#
function(add_gyb_dependencies gybInputFiles externalTarget)
    set(targetDependencies)

    foreach(inputFile ${gybInputFiles})
        STRING(REGEX REPLACE ".gyb\$" "" outputFile "${inputFile}")

        add_custom_command(
                DEPENDS "${inputFile}"
                OUTPUT "${outputFile}"
                COMMAND "${GYBTOOL}"
                ARGS --line-directive '' -o "${outputFile}" "${inputFile}"
        )
        list(APPEND targetDependencies "${outputFile}")
    endforeach(inputFile)

    set(targetName "${externalTarget}-gyb")

    add_custom_target(${targetName}
            DEPENDS ${targetDependencies} build-tools
            )
    add_dependencies(${externalTarget} ${targetName})
endfunction(add_gyb_dependencies)

#
# Clean the sticky package
#
add_custom_target(sticky-package-clean
        COMMAND swift package clean
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        )

#
# Build xcode project Target
#
add_custom_target(sticky-xcode-project
        COMMAND swift package generate-xcodeproj --enable-code-coverage
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        SOURCES Package.swift)

add_subdirectory(Sources)
add_subdirectory(Tests)
