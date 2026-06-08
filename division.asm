ORG 0000H
SJMP 0030H

ORG 0030H
MOV A, #02H       ; Numerator MUST be in A
MOV B, #02H       ; Denominator MUST be in B
DIV AB            ; Divide A by B (Result: A = 01H (Quotient), B = 00H (Remainder))

END
