#include <lpc214x.h>

int main(void) {
    unsigned long int temp = 0;
    unsigned int i;

    PINSEL1 = 0x00000000; 
    IO0DIR  = 0x00FF0000; // Set P0.16 to P0.23 as Output

    while(1) {
        // Ramp Up Phase
        for(i = 0; i < 255; i++) {
            temp = i;
            temp = (temp << 16) & 0x00FF0000;
            IO0PIN = temp;
        }
        
        // Ramp Down Phase
        for(i = 255; i > 0; i--) {
            temp = i;
            temp = (temp << 16) & 0x00FF0000;
            IO0PIN = temp; // Fixed typo from IO0DIR to IO0PIN
        }
    }
    return 0;
}
