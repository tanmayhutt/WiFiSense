#include <lpc214x.h>

// Function Declarations (using underscores instead of hyphens)
void clock_wise(void);
void anti_clock_wise(void);

// Global variable for software delays
volatile unsigned int j; 

int main(void) {
    // Set pins P0.8 and P0.11 as OUTPUT channels (0x00000100 | 0x00000800 = 0x00000900)
    IO0DIR = 0x00000900; 

    while(1) {
        // Step 1: Rotate Clockwise
        clock_wise();
        for(j = 0; j < 80000; j++); // Direction transition delay

        // Step 2: Rotate Anti-Clockwise
        anti_clock_wise();
        for(j = 0; j < 80000; j++); // Direction transition delay
    }
    return 0;
}

// Function to drive DC Motor Clockwise
void clock_wise(void) {
    IO0CLR = 0x00000900;         // Clear both control pins (Stop motor briefly)
    IO0SET = 0x00000100;         // Set P0.8 HIGH and keep P0.11 LOW
    for(j = 0; j < 1000000; j++); // Maintain rotation for a period
}

// Function to drive DC Motor Anti-Clockwise
void anti_clock_wise(void) {
    IO0CLR = 0x00000900;         // Clear both control pins (Stop motor briefly)
    IO0SET = 0x00000800;         // Set P0.11 HIGH and keep P0.8 LOW
    for(j = 0; j < 1000000; j++); // Maintain rotation for a period
}
