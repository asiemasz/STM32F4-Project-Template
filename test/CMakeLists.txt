enable_testing()

set(NAME ${PROJECT_NAME}_tests)

set(UNIT_TEST_SRC
    sample.cpp
)

add_executable(${NAME} ${UNIT_TEST_SRC})

target_link_libraries(${NAME} PRIVATE GTest::gtest GTest::gtest_main)
target_include_directories(${NAME} PRIVATE ${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

include(GoogleTest)
gtest_discover_tests(${NAME})