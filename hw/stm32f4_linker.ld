/** Configured for SMT32F407G-DISC1 **/

/* Definition of the memories available on board */
MEMORY {
   FLASH          (rx)  : ORIGIN = 0x08000000, LENGTH = 1M
   RAM           (rwx) : ORIGIN = 0x20000000, LENGTH = 112K
   AUX_RAM       (rwx) : ORIGIN = 0x2001C000, LENGTH = 16K
   CCM_RAM       (rwx) : ORIGIN = 0x10000000, LENGTH = 64K
   BACKUP_RAM    (rwx) : ORIGIN = 0x40024000, LENGTH = 4K
}

__flash_start__ = ORIGIN(FLASH);
__flash_end__ = ORIGIN(FLASH) + LENGTH(FLASH);
__ram_start__ = ORIGIN(RAM);
__ram_end__ = ORIGIN(RAM) + LENGTH(RAM);
__ccm_ram_start__ = ORIGIN(CCM_RAM);
__ccm_ram_end__ = ORIGIN(CCM_RAM) + LENGTH(CCM_RAM);
__aux_ram_start__ = ORIGIN(AUX_RAM);
__aux_ram_end__ = ORIGIN(AUX_RAM) + LENGTH(AUX_RAM);
__bkp_ram_start__ = ORIGIN(BACKUP_RAM);
__bkp_ram_end__ = ORIGIN(BACKUP_RAM) + LENGTH(BACKUP_RAM);

/* Stack size can be user defined */
__stack_size__ = 32k;

/* Entry point for the program  */
ENTRY(Reset_Handler);

/* Definition of the output sections */
SECTIONS {
   /** Interrupt service routines vector **/
   .isr_vector : {
      . = ALIGN(4);
   /* For this section optimalization must be skipped */
      KEEP(*(.isr_vector))
      . = ALIGN(4);
   } > FLASH

   /** Program instructions **/
   .text : {
      . = ALIGN(4);
      _text = .;
		*(.text);
		*(.text*);
      *(.glue_7)
      *(.glue_7t)
      *(.eh_frame)
      KEEP(*(.init))
      KEEP(*(.fini))
      . = ALIGN(4);
      _etext = .;
   } > FLASH

   /** Read-only data (constants Definition of thed in code) **/
   .rodata : {
      . = ALIGN(4);
      _srodata = .;
      *(.rodata);
		*(.rodata*);
      . = ALIGN(4);
      _erodata = .;
   } > FLASH

  .ARM.extab   : {
    . = ALIGN(4);
    *(.ARM.extab* .gnu.linkonce.armextab.*)
    . = ALIGN(4);
  } >FLASH

  .ARM : {
    . = ALIGN(4);
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
    . = ALIGN(4);
  } >FLASH

  .preinit_array     :
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
    . = ALIGN(4);
  } >FLASH

  .init_array :
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
    . = ALIGN(4);
  } >FLASH

  .fini_array :
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    PROVIDE_HIDDEN (__fini_array_end = .);
    . = ALIGN(4);
  } >FLASH

   /** Initialized global and static variables **/
   .data : {
      . = ALIGN(4);
      __init_data__ = LOADADDR(.data);
      __data_start__ = .;
      *(.data)
      *(.data*)
      . = ALIGN(4);
      __data_end__ = .;
   } > RAM AT> FLASH

   /** Unitialized global and static variables **/
   .bss : {
      . = ALIGN(4);
      __bss_start__ = .;
      *(.bss)
      *(.bss*)
      *(COMMON)
      . = ALIGN(4);
      __bss_end__ = .;
   } > RAM
	
   .stack : {
      . = ALIGN(8);
      __stack_start__ = .;
      . += __stack_size__;
      . = ALIGN(8);
      __stack_end__ = .;
   } > RAM

   . = ALIGN(4);
   __heap_start__ = .;
   . = ALIGN(4);
   __heap_end__ = .;

   .stab 				0 (NOLOAD) : { *(.stab) }
	.stabstr 			0 (NOLOAD) : { *(.stabstr) }
	/* DWARF debug sections.
	* Symbols in the DWARF debugging sections are relative to the beginning
	* of the section so we begin them at 0. */
	/* DWARF 1 */
	.debug				0 : { *(.debug) }
	.line				0 : { *(.line) }
	/* GNU DWARF 1 extensions */
	.debug_srcinfo		0 : { *(.debug_srcinfo) }
	.debug_sfnames		0 : { *(.debug_sfnames) }
	/* DWARF 1.1 and DWARF 2 */
	.debug_aranges		0 : { *(.debug_aranges) }
	.debug_pubnames		0 : { *(.debug_pubnames) }
	/* DWARF 2 */
	.debug_info			0 : { *(.debug_info .gnu.linkonce.wi.*) }
	.debug_abbrev		0 : { *(.debug_abbrev) }
	.debug_line			0 : { *(.debug_line) }
	.debug_frame		0 : { *(.debug_frame) }
	.debug_str			0 : { *(.debug_str) }
	.debug_loc			0 : { *(.debug_loc) }
	.debug_macinfo		0 : { *(.debug_macinfo) }
	/* SGI/MIPS DWARF 2 extensions */
	.debug_weaknames	0 : { *(.debug_weaknames) }
	.debug_funcnames	0 : { *(.debug_funcnames) }
	.debug_typenames	0 : { *(.debug_typenames) }
	.debug_varnames		0 : { *(.debug_varnames) }

	.note.gnu.arm.ident	0 : { KEEP(*(.note.gnu.arm.ident)) }
   .note.gnu.build-id	0 : { KEEP(*(.note.gnu.build-id)) }
	.ARM.attributes		0 : { KEEP(*(.ARM.attributes)) }
	/DISCARD/				: { *(.note.GNU-stack) }	
}