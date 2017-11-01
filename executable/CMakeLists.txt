cmake_minimum_required(VERSION 3.0)
project(executable)

if(NOT DISABLE_CONAN)
    SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
    include(cmake/ProjectSettings.cmake)
    conan_cmake_run(CONANFILE conanfile.py
            BASIC_SETUP CMAKE_TARGETS
            BUILD missing)
else(NOT DISABLE_CONAN)
    add_library(PKG::library_b INTERFACE IMPORTED)
    set_property(TARGET PKG::library_b PROPERTY INTERFACE_LINK_LIBRARIES ${library_b_BINARY_DIR}/liblibrary_b.a PKG::library_a)
    set_property(TARGET PKG::library_b PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${library_b_SOURCE_DIR}/include)

    add_library(PKG::library_a INTERFACE IMPORTED)
    set_property(TARGET PKG::library_a PROPERTY INTERFACE_LINK_LIBRARIES ${library_a_BINARY_DIR}/liblibrary_a.a)
    set_property(TARGET PKG::library_a PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${library_a_SOURCE_DIR}/include)
endif(NOT DISABLE_CONAN)

if(DEPENDS_ON_A)
    add_definitions(-DDIRECT_DEPENDECY_ON_A)
endif(DEPENDS_ON_A)

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

# Linking fails if we use the following line to specify targets if we do NOT have a direct dependency on library_a
#target_link_libraries(executable PKG::library_b PKG::library_a)

if(NOT DISABLE_CONAN)
    conan_target_link_libraries(executable)
else(NOT DISABLE_CONAN)
    if(DEPENDS_ON_A)
        target_link_libraries(executable PKG::library_b PKG::library_a)
    else(DEPENDS_ON_A)
        target_link_libraries(executable PKG::library_b)
    endif(DEPENDS_ON_A)
endif(NOT DISABLE_CONAN)




