.ORIG x3000
        LEA R1, STRZ
        AND R2, R2, #0 
        LD  R4, CHAR

REPEAT  LDR R3, R1, #0	
        BRz FINISH		;Branch if null
        ADD R3, R3, R4
        BRnp PASS		;Branch if not ' '
        ADD R2, R2, #1
PASS    ADD R1, R1, #1
        BR  REPEAT		;Always branch

FINISH  ST  R2, COUNT
        HALT

CHAR    .FILL xFFE0
COUNT   .FILL x0000
STRZ    .STRINGZ "This is CS252!"
 .END
