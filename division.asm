ORG 0000H         ; Reset vector address
SJMP 30H          ; Short jump to main program

ORG 30H           ; Main program starts at 0030H
MOV A, #02H       ; Load numerator (2) into Accumulator
MOV B, #02H       ; Load denominator (2) into Register B
DIV AB            ; Divide A by B (A / B) -> 2 / 2

END               ; End of assembly code
