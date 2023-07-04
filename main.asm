; Configuration bits settings
CONFIG FOSC = INTOSCIO ; Internal oscillator, I/O on RA6/OSC2/CLKOUT pin
CONFIG WDTE = OFF ; Watchdog Timer disabled
CONFIG PWRTE = OFF ; Power-up Timer disabled
CONFIG MCLRE = OFF ; MCLR pin is input, weak pull-up enabled
CONFIG CP = OFF ; Code protection disabled
CONFIG LVP = OFF ; Low-voltage programming disabled

; Include the necessary header files
#include <xc.inc>

; Macros
#define LED_PIN RA0

; Constants
DELAY_COUNT EQU 500

; Variables
ORG 0x00 ; Reset vector
GOTO main

; Delay function
DELAY_MS:
    MOVLW 0xFF
    MOVWF DELAY_COUNT+1
DELAY_LOOP:
    MOVLW 0xFF
    MOVWF DELAY_COUNT
DELAY_LOOP2:
    DECFSZ DELAY_COUNT, F
    GOTO DELAY_LOOP2
    DECFSZ DELAY_COUNT+1, F
    GOTO DELAY_LOOP
    RETURN

; Main function
main:
    ; Configure oscillator to 8MHz
    MOVLW 0x0F
    MOVWF OSCCON

    ; Configure I/O pins
    BANKSEL TRISA
    MOVLW 0xFE ; Set RA0 as output
    MOVWF TRISA

    ; Infinite loop
LOOP:
    ; Toggle the LED
    BANKSEL LATA
    MOVF LATA, W
    XORLW 0x01
    MOVWF LATA

    ; Delay for 500 milliseconds
    CALL DELAY_MS, 0x00F4 ; Call the delay function with 500 milliseconds (assuming 8MHz oscillator)

    ; Jump back to the loop
    GOTO LOOP

    END
