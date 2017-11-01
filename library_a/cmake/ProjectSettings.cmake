#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_DEBUG_POSTFIX "_d")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Uncomment from next two lines to force static or dynamic library, default is autodetection
if(BUILD_STATIC)
    set( LIB_MODE STATIC )
    message(STATUS "Building static libraries")
else(BUILD_STATIC)
    set( LIB_MODE SHARED )
    message(STATUS "Building dynamic libraries")
endif(BUILD_STATIC)

if(WIN32)
    # Enable unicode for windows builds
    add_definitions(-DUNICODE -D_UNICODE)
    if(MINGW)
        # Let us try to enable secure api
        add_definitions(-DMINGW_HAS_SECURE_API)
        # Set the -municode flag for MinGW builds.
        # To avoid external dependencies to C and C++ runtime libraries, we try to link statically against them.
        # This results in an error when two or more dynamic libraries are linked together so to overcome this we allow multiple definitions.
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -municode -static-libgcc -static-libstdc++ -Wl,--allow-multiple-definition")
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -municode -static-libgcc -static-libstdc++ -Wl,--allow-multiple-definition")
        set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -municode -static-libgcc -static-libstdc++ -Wl,--allow-multiple-definition")
    endif(MINGW)
    if(MSVC)
        message("-- * Setting Visual Studio flags")
        # Set as Windows general definition in ProjectSettings.cmake: add_definitions(-DUNICODE -D_UNICODE)
        add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NON_CONFORMING_SWPRINTFS -D_SCL_SECURE_NO_WARNINGS)
    endif(MSVC)
endif(WIN32)

option(CMAKE_ENABLE_CONAN  "Enable support for Conan within CMake" ON)

if(CMAKE_ENABLE_CONAN)
    # Download automatically, you can also just copy the conan.cmake file
    if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
        message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
        file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/master/conan.cmake"
                "${CMAKE_BINARY_DIR}/conan.cmake")
    endif()

    include(${CMAKE_BINARY_DIR}/conan.cmake)

    macro(conan_include)
        set(_OPTIONS_ARGS)
        set(_ONE_VALUE_ARGS)
        set(_MULTI_VALUE_ARGS TARGETS)

        cmake_parse_arguments(_CONANINCLUDE "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN} )

        # Mandatory
        if( _CONANINCLUDE_TARGETS )
            message( STATUS "inside TARGETS=${_CONANINCLUDE_TARGETS}" )
            foreach(_target ${_CONANINCLUDE_TARGETS})
                get_property(_dir TARGET ${_target} PROPERTY INTERFACE_INCLUDE_DIRECTORIES)
                message(STATUS "Target: ${_target} => ${_dir}")

                include_directories(${_dir})
            endforeach(_target)
        else()
            message( FATAL_ERROR "conan_include: 'TARGETS' argument required." )
        endif()
    endmacro(conan_include)

    # This is not defined for cmake multi target generator, so we write it here
    macro(conan_multi_set_find_library_paths)
        if(CONAN_CMAKE_MULTI)
            # For find_library
            set(CMAKE_INCLUDE_PATH ${CONAN_INCLUDE_DIRS_RELEASE} ${CONAN_INCLUDE_DIRS_DEBUG} ${CMAKE_INCLUDE_PATH})
            set(CMAKE_LIBRARY_PATH ${CONAN_LIB_DIRS_RELEASE} ${CONAN_LIB_DIRS_DEBUG} ${CMAKE_LIBRARY_PATH})
        endif(CONAN_CMAKE_MULTI)
    endmacro(conan_multi_set_find_library_paths)

endif(CMAKE_ENABLE_CONAN)
