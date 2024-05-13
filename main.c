#include <xc.h>
#include <stdint.h>

// bits settings
#pragma config FOSC = INTOSCIO  // Internal oscillator, I/O on RA6/OSC2/CLKOUT pin
#pragma config WDTE = OFF      // Watchdog Timer disabled
#pragma config PWRTE = OFF     // Power-up Timer disabled
#pragma config MCLRE = OFF     // MCLR pin is input, weak pull-up enabled
#pragma config CP = OFF        // Code protection disabled
#pragma config LVP = OFF       // Low-voltage programming disabled

// delay
void delay_ms(uint16_t milliseconds) {
    while (milliseconds) {
        __delay_ms(1);
        milliseconds--;
    }
}


void main(void) {
    //oscillator at 8MHz
    OSCCONbits.IRCF = 0b1111;  // Set IRCF bits to 1111 (8MHz)
    //I/O pins
    TRISAbits.TRISA0 = 0;  // Set RA0 as output
    while (1) {
        LATAbits.LATA0 = ~LATAbits.LATA0;
        // Delay500 milliseconds
        delay_ms(500);
        delay_ms(500);
        delay_ms(500);
        delay_ms(500);
        delay_ms(500);
    }
}
