ORG 0000H
SJMP 0030H

ORG 0030H
MOV A, #03H       ; First number MUST be in A
MOV B, #02H       ; Second number MUST be in B
MUL AB            ; Multiply A and B (Result: A = 06H, B = 00H)

END
