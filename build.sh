#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage ./build.sh [target|unit_test]"
    exit
fi

if [[ $1 == "target" ]]; then
    cmake -S . -B build/target -DCMAKE_TOOLCHAIN_FILE=toolchain-STM32F407.cmake 
    cmake --build build/target
else
    cmake -S . -B build/host_tests
    cmake --build build/host_tests
fi

