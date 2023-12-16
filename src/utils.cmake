function(generate_hex_file TARGET)
    set(ELF_FILE ${TARGET}.elf)
    set(HEX_FILE ${TARGET}.hex)

    add_custom_command(
        OUTPUT ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -O ihex ${ELF_FILE} ${HEX_FILE}
        DEPENDS ${ELF_FILE}
    )

    add_custom_target(${HEX_FILE} ALL DEPENDS ${CMAKE_BINARY_DIR}/src/${HEX_FILE})
endfunction(generate_hex_file)

function(generate_bin_file TARGET)
    set(ELF_FILE ${TARGET}.elf)
    set(BIN_FILE ${TARGET}.bin)

    add_custom_command(
        OUTPUT ${BIN_FILE}
        COMMAND ${CMAKE_OBJCOPY} -O binary ${ELF_FILE} ${BIN_FILE}
        DEPENDS ${ELF_FILE}
    )

    add_custom_target(${BIN_FILE} ALL DEPENDS ${CMAKE_BINARY_DIR}/src/${BIN_FILE})
endfunction(generate_bin_file)

function(generate_listing_file TARGET)
    set(ELF_FILE ${TARGET}.elf)
    set(LSS_FILE ${TARGET}.lss)
    
    add_custom_command(
        OUTPUT ${LSS_FILE}
        COMMAND ${CMAKE_OBJDUMP} -h -S ${ELF_FILE} > ${LSS_FILE}
        DEPENDS ${ELF_FILE}
    )

    add_custom_target(${LSS_FILE} ALL DEPENDS ${CMAKE_BINARY_DIR}/src/${LSS_FILE})
endfunction(generate_listing_file)

function(generate_memory_dump TARGET)
    set(ELF_FILE ${TARGET}.elf)
    set(DMP_FILE ${TARGET}.dmp)
    
    add_custom_command(
        OUTPUT ${DMP_FILE}
        COMMAND ${CMAKE_OBJDUMP} -x --syms ${ELF_FILE} > ${DMP_FILE}
        DEPENDS ${ELF_FILE}
    )

    add_custom_target(${DMP_FILE} ALL DEPENDS ${CMAKE_BINARY_DIR}/src/${DMP_FILE})
endfunction(generate_memory_dump)