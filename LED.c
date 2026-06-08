#include <lpc214x.h>  // Correct header file for LPC2148

int main() {
    // Use volatile so the compiler doesn't optimize away the delay loops
    volatile unsigned int delay; 

    // Configure Pin Function Select register 1 to GPIO mode for Port 0 pins
    PINSEL1 = 0x00000000; 
    
    // Set Port 0 pins P0.16 to P0.23 as OUTPUT (1 = Output, 0 = Input)
    IO0DIR = 0x00FF0000;  

    while(1) {
        // 1. Turn LEDs ON by setting pins P0.16 through P0.23 high
        IO0SET = 0x00FF0000; 
        
        // Software Delay Loop
        for (delay = 0; delay < 500000; delay++); 

        // 2. Turn LEDs OFF by clearing pins P0.16 through P0.23 low
        IO0CLR = 0x00FF0000; 
        
        // Software Delay Loop
        for (delay = 0; delay < 500000; delay++); 
    }
    
    return 0; // Standard main completion (though loop runs infinitely)
}
