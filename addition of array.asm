        AREA ADDITION, CODE, READONLY
        ENTRY

START
        MOV R5, #6        ; R5 acts as our loop counter (6 elements)
        MOV R0, #0        ; R0 acts as our sum accumulator (Clear to 0)
        LDR R1, =VALUE1   ; Load the starting memory address of the array

LOOP
        LDRH R3, [R1], #2 ; Load 16-bit halfword into R3, then advance R1 by 2 bytes
        ADD R0, R0, R3    ; Accumulate sum: R0 = R0 + R3
        SUBS R5, R5, #1   ; Decrement loop counter and update flags
        BNE LOOP          ; If R5 is not zero, branch back to LOOP

        LDR R4, =RESULT   ; Load the memory address of the RAM result variable
        STR R0, [R4]      ; Store the final sum into RAM location 'RESULT'

BACK
        B BACK            ; Infinite loop to safely halt the program

;-------------------------------------------------------------------------
; Data Section (Read-Only Array)
;-------------------------------------------------------------------------
VALUE1  DCW 0x1111, 0x0002, 0x0003, 0x0002, 0x0001, 0x0001

;-------------------------------------------------------------------------
; Data Section (Read-Write RAM Storage)
;-------------------------------------------------------------------------
        AREA DATA2, DATA, READWRITE
RESULT  DCD 0x0
        END               ; End of file (Leave one blank line below this!)
