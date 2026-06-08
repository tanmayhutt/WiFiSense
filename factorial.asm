        AREA FACTORIAL, CODE, READONLY
        ENTRY

START
        MOV R0, #3        ; We want to find the factorial of 3 (3!)
        MOV R1, #2        ; Start multiplier at (R0 - 1), which is 2

FACT
        MUL R3, R0, R1    ; R3 = R0 * R1 -> (First pass: 3 * 2 = 6)
        MOV R0, R3        ; Move the product back into R0
        SUBS R1, R1, #1   ; Decrement our multiplier counter by 1
        CMP R1, #1        ; Check if our multiplier has hit 1
        BNE FACT          ; If R1 is NOT YET 1, loop back to keep multiplying

STOP
back
        B back            ; Infinite branch to self to safely halt the program
        NOP               ; No Operation
        NOP               ; No Operation
        END               ; End of file (remember to hit enter to leave a blank line below)
