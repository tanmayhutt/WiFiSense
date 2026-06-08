ORG 0000H         ; Reset vector address
SJMP 30H          ; Short jump to the main program area to skip vector table

ORG 30H           ; Main program starts at address 0030H
MOV R1, #03H      ; Load immediate value 3 into Register 1
MOV A, #02H       ; Load immediate value 2 into the Accumulator
ADD A, R1         ; Add R1 to A (A = A + R1) -> A = 2 + 3

END               ; End of assembly code
