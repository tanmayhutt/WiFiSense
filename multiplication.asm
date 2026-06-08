ORG 0000H         ; Reset vector address
SJMP 30H          ; Short jump to main program

ORG 30H           ; Main program starts at 0030H
MOV A, #03H       ; Load immediate value 3 into Accumulator
MOV B, #02H       ; Load immediate value 2 into Register B
MUL AB            ; Multiply A and B (A * B) -> 3 * 2

END               ; End of assembly code
