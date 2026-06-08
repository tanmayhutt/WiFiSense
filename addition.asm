ORG 0000H
SJMP 0030H        ; Jump to main program

ORG 0030H
MOV R1, #03H      ; Load 3 into Register 1
MOV A, #02H       ; Load 2 into Accumulator
ADD A, R1         ; A = A + R1 (Result: A = 05H)

END
