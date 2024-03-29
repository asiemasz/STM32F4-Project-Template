#include "stm32f4xx.h"

#include "core_init.h"

// Default settings (for 168 MHz)
#ifndef PLL_Q
#define PLL_Q 4
#endif
#ifndef PLL_M
#define PLL_M 4
#endif
#ifndef PLL_N
#define PLL_N 168
#endif
#ifndef PLL_P
#define PLL_P 2
#endif

#define USE_FPU

void core_init() {
  /* Start HSE and wait for it to be ready */
  RCC->CR |= RCC_CR_HSEON;
  while (!(RCC->CR & RCC_CR_HSERDY))
    ;

  /* FLASH configuration*/
  FLASH->ACR = FLASH_ACR_ICEN |       /* instruction cache */
               FLASH_ACR_DCEN |       /* data cache */
               FLASH_ACR_PRFTEN |     /* prefetch enable */
               FLASH_ACR_LATENCY_4WS; /* 4 wait states */

  /* Set HSE as PLL source, set M, N, P, Q multipliers and dividers */
  RCC->PLLCFGR = (PLL_Q << 24) | RCC_PLLCFGR_PLLSRC_HSE |
                 (((PLL_P >> 1) - 1) << 16) | (PLL_N << 6) | PLL_M;
  RCC->CR |= RCC_CR_PLLON;
  while (!(RCC->CR & RCC_CR_PLLRDY))
    ;

  /* PLL as core source clock, prescaler 1 for APB2, prescaler 2 for APB1 */
  RCC->CFGR |= RCC_CFGR_PPRE1_DIV4 | RCC_CFGR_PPRE2_DIV2 | RCC_CFGR_SW_PLL;
  while (!(RCC->CFGR & RCC_CFGR_SWS_PLL))
    ;

#if defined(USE_FPU)
  /* FPU initialization */
  SCB->CPACR |= ((3 << 10 * 2) | (3 << 11 * 2));
#endif
}