;OUTLINE
;	R0 Loop index = 4
;	R1 Loc1
;	R2 TEMP storage for current value
;	R3 Value to return per subroutine
;	R7 Addr of next instrction	
;	
;	if R0 > 0
;	Subroutine 
;		R1 = R1 / 2
;	Store R0 to Loc 2
;
		.ORIG x3000
;Initialize registers
		AND		R0, R0, #0
		ADD 	R0, R0, #4	;Initialize R0 to 4
		AND 	R1, R1, #0
		LD 		R1, Loc1
;Loop
REPEAT 	JSR 	SUBRT1
ADD 	R0, R0, #-1
		BRp 	REPEAT
;
		ST 		R1, Loc2
STOP 	HALT
;
SUBRT1 	ADD 	R2, R1, #0 	;Store the curent value into R2
		AND 	R3, R3, #0 	;Counter
SUBLP	ADD 	R2, R2, #-2 ;Subtract R2 by 2
		BRn 	SUBEND 		;Repeat until R2 is negative
		ADD 	R3, R3, #1 ;When R2 is non-negative, add counter by 1
		BRnzp 	SUBLP 		;Branch to the start of the loop
SUBEND	ADD 	R1, R3, #0 	;Store the devided value to R1
		RET
;
Loc1 	.BLKW 	1
Loc2 	.BLKW 	1
;
		.END