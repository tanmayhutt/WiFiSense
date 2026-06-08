#include <lpc214x.h>

void delay(void);

int main(void) {
    PINSEL0 = 0x00000000; 
    PINSEL1 = 0x00000000; 
    IO0DIR  = 0x00FF0000; // Set P0.16 to P0.23 as Output

    while(1) {
        IO0PIN = 0x00000000; // Drop all output lines Low (0V)
        delay();
        
        IO0PIN = 0x00FF0000; // Drive all output lines High (3.3V)
        delay();
    }
    return 0;
}

// Software Delay Loop
void delay(void) {
    volatile unsigned int i; // Added volatile to prevent compiler optimization
    for(i = 0; i < 50000; i++);
}
