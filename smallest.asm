AREA SMALLEST,CODE,READONLY
ENTRY

    LDR R0,=ARR
    MOV R1,#4          ; Remaining elements

    LDR R2,[R0],#4     ; First element -> R2

LOOP
    LDR R3,[R0],#4     ; Next element
    CMP R2,R3
    MOVGT R2,R3        ; If R2 > R3, update smallest

    SUBS R1,R1,#1
    BNE LOOP

STOP
    B STOP

ARR DCD 10,25,15,40,30

END
