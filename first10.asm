        AREA SUM, CODE, READONLY
        ENTRY

START
        MOV R1, #10       ; Initialize counter R1 = 10
        MOV R2, #0        ; Initialize sum accumulator R2 = 0

loop
        ADD R2, R2, R1    ; R2 = R2 + R1
        SUBS R1, R1, #0x01; Decrement R1 by 1 and update flags
        BNE loop          ; If R1 is not 0, jump back to loop

back
        B back            ; Infinite loop to stop program from crashing
        END               ; End of the file (Must have a blank line after this)
