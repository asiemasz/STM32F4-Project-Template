set(NAME ${PROJECT_NAME})

include(utils.cmake)

add_executable(${NAME}
    main.c
)

target_link_options(${NAME} PRIVATE
    -T${CMAKE_CURRENT_SOURCE_DIR}/../hw/stm32f4_linker.ld
    LINKER:--print-memory-usage
    LINKER:-Map,${CMAKE_CURRENT_BINARY_DIR}/${NAME}.map
)

set_target_properties(${NAME} PROPERTIES
    SUFFIX .elf
)

target_include_directories( ${NAME} PRIVATE
    ../hw/cmsis
    ../hw
)

target_link_libraries(${NAME} PRIVATE hw_platform)

generate_hex_file(${NAME})
generate_bin_file(${NAME})
generate_listing_file(${NAME})
generate_memory_dump(${NAME})