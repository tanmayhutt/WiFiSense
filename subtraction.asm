ORG 0000H         ; Reset vector address
SJMP 30H          ; Short jump to main program

ORG 30H           ; Main program starts at 0030H
MOV R1, #02H      ; Load immediate value 2 into Register 1
MOV A, #05H       ; Load immediate value 5 into the Accumulator
CLR C             ; Clear the carry flag to prevent unintended borrow subtraction
SUBB A, R1        ; Subtract R1 from A (A = A - R1 - C) -> A = 5 - 2 - 0

END               ; End of assembly code
