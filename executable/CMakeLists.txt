cmake_minimum_required(VERSION 3.0)
project(executable)

include(cmake/ProjectSettings.cmake)
conan_cmake_run(CONANFILE conanfile.py
        BASIC_SETUP CMAKE_TARGETS
        BUILD missing)

set(SOURCES
        src/Executable.cpp)

set(HEADERS
        src/Executable.h)

add_executable(executable ${SOURCES} ${HEADERS})
target_include_directories(executable
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        )
conan_target_link_libraries(executable)

