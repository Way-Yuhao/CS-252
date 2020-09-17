		.ORIG x3000
;Initializing registers
		AND 	R0, R0,	#0		;Reset Rregisters to zero
		AND		R1, R1, #0
		LD		R2,	MASK
		LD		R4, Loc1	;Set R4 for INPUT String
		ADD		R0, R0, #6
;	
;Loop begins
REPEAT	AND 	R3, R3, #0	;Indicates if there is a 1 present at the beginning
		AND 	R3, R2, R4	;Check if the first digit of INPUT is 1
		ADD		R4, R4, R4	;Shift the value stored in INPUT one digit to the left
		ADD		R3, R3, #0	;Set R3 as conditional code
		BRzp	FORWARD		;If the first digit is zero, skip the next instruction
		ADD		R4, R4, #1	;If true, add a 1 to the end of the string
FORWARD	ADD 	R0, R0, #-1	;Decrement the number of steps remaining in the loop by 1
		BRp		REPEAT
;
		ST 		R4, Loc2
STOP	HALT
;
MASK	.FILL	x8000		;whose value is 1000000000000000 in binary
Loc1 	.BLKW 	1
Loc2 	.BLKW 	1
;
		.END
		