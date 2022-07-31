/** Configured for SMT32F407G-DISC1 **/

/* Entry point for the program  */
ENTRY(Reset_Handler);

/* Definition of the memories available on board */
MEMORY {
   FLASH          (rx)  : ORIGIN = 0x08000000, LENGTH = 1M
   SRAM           (rwx) : ORIGIN = 0x20000000, LENGTH = 112K
   CCM_SRAM       (rwx) : ORIGIN = 0x10000000, LENGTH = 64K
   AUX_SRAM       (rwx) : ORIGIN = 0x2001C000, LENGTH = 16K
   BACKUP_SRAM    (rwx) : ORIGIN = 0x40024000, LENGTH = 4K
}

__flash_start__ = ORIGIN(FLASH);
__flash_end__ = ORIGIN(FLASH) + LENGTH(FLASH);
__sram_start__ = ORIGIN(SRAM);
__sram_end__ = ORIGIN(SRAM) + LENGTH(SRAM);

/* Stack size can be user defined */
_stack_size = 30K;

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
      *(.text)
      . = ALIGN(4);
      _etext = .;
   } > FLASH

   /** Read-only data (constants Definition of thed in code) **/
   .rodata : {
      . = ALIGN(4);
      _srodata = .;
      *(.rodata)
      . = ALIGN(4);
      _erodata = .;
   } > FLASH

   /** Initialized global and static variables **/
   .data : {
      . = ALIGN(4);
      __init_data__ = LOADADDR(.data);
      __data_start__ = .;
      *(.data)
      . = ALIGN(4);
      __data_end__ = .;
   } > SRAM AT> FLASH

   /** Unitialized global and static variables **/
   .bss : {
      . = ALIGN(4);
      __bss_start__ = .;
      *(.bss)
      *(COMMON)
      . = ALIGN(4);
      __bss_end__ = .;
   } > SRAM

   /** Definition of the stack (size can be customized) **/
   __stack_start__ = __sram_end__; 
   __stack_end__ = __stack_start__ - _stack_size;
}