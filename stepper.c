#include <lpc214x.h>

// Function Declarations (using underscores instead of hyphens)
void clock_wise(void);
void anti_clock_wise(void);

// Global variables for software delays
volatile unsigned long int j; 

// 4-step commutation sequence for stepper motor step control
// P0.11 to P0.8 pins step sequences
unsigned int clk_sequence[4]  = {0x00000100, 0x00000200, 0x00000400, 0x00000800}; // Step 1 to 4
unsigned int Aclk_sequence[4] = {0x00000800, 0x00000400, 0x00000200, 0x00000100}; // Reversed sequence

int main(void) {
    PINSEL2 = 0x00000800; // Configure pin connections for debug/GPIO compatibility
    IO0DIR  = 0x00000F00; // Set pins P0.8, P0.9, P0.10, P0.11 as OUTPUT channels

    while(1) {
        // Rotate Clockwise
        clock_wise();
        for(j = 0; j < 800000; j++); // Delay between direction change

        // Rotate Anti-Clockwise
        anti_clock_wise();
        for(j = 0; j < 800000; j++); // Delay between direction change
    }
    return 0;
}

// Function to rotate stepper motor clockwise
void clock_wise(void) {
    unsigned int i;
    // Step through the 4 distinct magnetic phase alignments
    for(i = 0; i < 4; i++) {
        IO0CLR = 0x00000F00;         // Clear old step pattern data pins
        IO0SET = clk_sequence[i];    // Apply new step configuration
        for(j = 0; j < 10000; j++);  // Inter-step delay to allow motor rotor to move
    }
}

// Function to rotate stepper motor anti-clockwise
void anti_clock_wise(void) {
    unsigned int i;
    // Step through the reversed phase alignments
    for(i = 0; i < 4; i++) {
        IO0CLR = 0x00000F00;         // Clear old step pattern data pins
        IO0SET = Aclk_sequence[i];   // Apply reversed step configuration
        for(j = 0; j < 10000; j++);  // Inter-step delay to allow motor rotor to move
    }
}
