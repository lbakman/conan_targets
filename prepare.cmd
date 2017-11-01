@echo off

REM Only execute this if you are running the conan.io version

pushd library_a
conan export lb/testing
popd

pushd library_b
conan export lb/testing
popd

