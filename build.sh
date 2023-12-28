#!/bin/bash

USAGE="Usage: $(basename $0) [-v [reset | clean | debug | release | unit_tests]]" 

BUILD=./build
BUILD_DIR=$BUILD/debug
TYPE=DEBUG
IS_UNIT_TEST=
CLEAN=
RESET=
VERBOSE=
TOOLCHAIN_ARG=

for arg; do
    case "$arg" in
        -h)         echo $USAGE; exit 0;;
        -v)         VERBOSE="VERBOSE=1";;
        unit_test)  IS_UNIT_TEST=1;BUILD_DIR=$BUILD/unit_test;;
        debug)      TYPE=DEBUG; BUILD_DIR=$BUILD/target/debug;;
        release)    TYPE=RELEASE; BUILD_DIR=$BUILD/target/release;;
        clean)      CLEAN=1;;
        reset)      RESET=1;;
        *)          echo -e "Option not known: $arg\n$USAGE"; exit 1;;
    esac
done

if [[ -z $IS_UNIT_TEST ]]; then
    TOOLCHAIN_ARG=-DCMAKE_TOOLCHAIN_FILE=toolchain-STM32F407.cmake
fi

if [[ -n $RESET ]]; then
    rm -rf $BUILD_DIR
fi

cmake -S . -B $BUILD_DIR -DCMAKE_BUILD_TYPE=$TYPE $TOOLCHAIN_ARG

if [[ -n $CLEAN ]]; then
    cmake --build $BUILD_DIR --target clean
fi

cmake --build $BUILD_DIR -- $VERBOSE