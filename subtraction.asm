ORG 0000H
SJMP 0030H

ORG 0030H
MOV R1, #02H      ; Load 2 into Register 1
MOV A, #05H       ; Load 5 into Accumulator
CLR C             ; CRITICAL: Clear carry so it doesn't subtract an extra 1
SUBB A, R1        ; A = A - R1 (Result: A = 03H)

END
