;NEED:
;	RO Address of pointer for original 
;	R1 Address of pointer for modifed 
;	R2 number of empty spaces
;	R3 ASCII of space 
;	R4 ASCII of %
;	R5 Compared results for space characters
;	R6 Current Character
;	Loop to iterate the entire loop
;		load current character
;		is it a space?
;			T - R0++
;			F - ST to 
;		R0++
;	Loop to add the rest of the space
;
;
		.ORIG x3000
;		
		LD 		R0, ORIADR
		LD 		R1, MODADR
		AND 	R2, R2, #0
		LD 		R3, SPACE
		LD 		R4, PCT
		AND 	R5, R5, #0
		AND 	R6, R6, #0
		LDR		R6, R0, #0	;Load the first character
;		
REPEAT	ADD 	R5, R6, R3	;The difference between current character and ' '
		BRnp	CHAR 		;Excecute code below if encountered space (Branch 1)
		ADD 	R2, R2, #1 	;Increment space count by 1
CHAR	ADD 	R5, R5, #0 	;Reset condition code
		BRz 	FORWARD 	;Excecute code below if not encountered space (Brach 2)
		STR 	R6, R1, #0	;Store the current character to the modifed string
		ADD 	R1, R1, #1 	;Point to the next location in modifed string
FORWARD ADD 	R0, R0, #1  ;Iterate to the next char in the original string
		LDR		R6, R0, #0	;Load the next character
		BRnp	REPEAT		;Exit out when encounters null, else return to loop
;
HEAD	ADD 	R2, R2, #0 	;Reset the conditional code to the number of spaces
		BRnz 	EXIT 		;If there are no more space remaining, exit loop
		STR 	R4, R1, #0  ;Store a "%" char to the next destination
		ADD 	R1, R1, #1  ;Point to the next location in the modified string
		ADD 	R2, R2, #-1 ;Decrease the number of spaces remaining by 1
		BRnzp 	HEAD
;
EXIT	AND 	R6, R6, #0 	;Reset R6 to 0
		STR 	R6, R1, #0 	;Store x0000 to the last position
		HALT
;
ORIADR	.FILL x5000
MODADR	.FILL x5100
SPACE	.FILL xFFE0			;2's complement of the ASCII value of space
PCT		.FILL x0025			;ASCII value of '%'
;
		HALT
		.END