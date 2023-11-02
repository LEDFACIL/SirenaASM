#include <xc.h>

#pragma config FOSC = INTOSCIO  // Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config LVP = OFF        // Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
#pragma config CPD = ON         // Data EE Memory Code Protection bit (Data memory code-protected)
#pragma config CP = ON          // Flash Program Memory Code Protection bit (0000h to 07FFh code-protected)

#define _XTAL_FREQ 4000000
#define tiempo1 700
#define tiempo2 555

void main(void) 
{
    TRISA = 0b11110000;  
    TRISB = 0b00000110; 
    CMCON = 0x07;
    PORTA = 0x00;
    PORTB = 0b10000000;    
    
    while (1) 
    {
        for(unsigned short contador = 0; contador <= 641; contador++)
        {
            PORTA = 0b00000100;
            __delay_us(tiempo2);
            PORTA = 0b00001000;
            __delay_us(tiempo2);                    
        }
        for(unsigned short contador = 0; contador <= 512; contador++)
        {
            PORTA = 0b00000100;
            __delay_us(tiempo1);
            PORTA = 0b00001000;
            __delay_us(tiempo1);                    
        }                
    }
}
