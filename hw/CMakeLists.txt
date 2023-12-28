set(NAME hw_platform)

set(SOURCES
    startup/stm32f4_startup.c
    startup/core_init.c
)

add_library(${NAME} STATIC ${SOURCES})

target_include_directories(${NAME} SYSTEM PRIVATE
    external
    external/cmsis
)

target_include_directories(${NAME} INTERFACE startup)