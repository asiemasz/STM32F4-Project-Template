enable_testing()

set(NAME ${PROJECT_NAME}_tests)

set(UNIT_TEST_SRC
    sample.cpp
)

add_executable(${NAME} ${UNIT_TEST_SRC})

# Supress warnings on external libs
target_compile_options(gtest PRIVATE "-w")
target_compile_options(gmock PRIVATE "-w")
target_compile_options(gtest_main PRIVATE "-w")
target_compile_options(gmock_main PRIVATE "-w")

target_link_libraries(${NAME} PRIVATE GTest::gtest GTest::gtest_main)
target_include_directories(${NAME} PRIVATE ${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

include(GoogleTest)
gtest_discover_tests(${NAME})