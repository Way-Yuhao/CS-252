;OUTLINE
;	R0: outer loop counter
;	R1: front String index
;	R2: rear String index
;	R3: temp storage for a character
;	R4: adress of the current character
;	R5: value of the current character
;
;Initialize registers
;Point R4 to the first character
;--Evaluating the length of the String--
;Loop
;		Load the current register into R5 and R2
;		Branch out if the value is x0000
;		Else, add R0 and R2 by 1
;		BRnpz front of the loop
;--Devide R0 by 2 for the number of repetitions--
;Need subroutine here
;		***
;--Outer loop for String modification
;		Point R1 to the front
;		Make sure R2 is pointed to the back
;		Call SUBRT2
;		R1++
;		R2--
;		R0--
;		END if R0 is non-positive
;--Swap characters by pair--
;SUBRT2
;		Load the front character to R3
;		Load the rear character to R5
;		Store R3 to the address stored in R2
;		Store R5 to the adress stored in R1		
;
;
			.ORIG 	x3000
;Initialize registers
			AND 	R0, R0, #0 	;Reset R0 (counter)
			LD 		R1, STR_ST 	;front char index
			LD 		R2, STR_ST 	;rear char index
			AND 	R3, R3, #0 	;temp storage for char
			AND 	R4, R4, #0 	;unused adress
			AND 	R5, R5, #0 	;value of current register
;Evaluate the length of the String
COUNT		LDR 	R3, R2, #0	;FIXME
			BRz 	COUNTEND
			ADD 	R0, R0, #1 	;Add counter by 1
			ADD 	R2, R2, #1 	;Point R2 to the next address
			BRnzp 	COUNT
;Calulate the number of character pairs to be swapped
COUNTEND 	AND 	R4, R4, #0 	;Temp register for counter
REPEAT		ADD 	R0, R0, #-2 
			BRn 	DEVIDEEND
			ADD 	R4, R4, #1	
			BRnzp 	REPEAT 	
DEVIDEEND	ADD 	R0, R4, #0 	;Store R4 to R0
			ADD 	R2, R2, #-1; ;Set R2 to the last char
			AND 	R4, R4, #0 	;Clear R4
;Swap characters
;Outer loop
SWAPLOOP	JSR 	SUBRT_SWAP
			ADD 	R1, R1, #1
			ADD 	R2, R2, #-1
			ADD 	R0, R0, #-1
			BRp 	SWAPLOOP
;
			LD 		R0, STR_ST
			PUTS	
STOP		HALT
;
SUBRT_SWAP	LDR 	R3, R1, #0
			LDR 	R4, R2, #0
			STR 	R4, R1, #0	;Swap
			STR 	R3, R2, #0	;Swap
			RET
;
STR_ST 		.FILL 	x5000
;
			.END 