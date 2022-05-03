			AREA PROJECT_2, CODE, Readonly
			ENTRY ;The first instruction to execute follows
			MOV r0, #0x40000000
N			EQU	10 ;number of cordinates
M			EQU 3  ;number of SETS
SET			DCD Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, Px, Py
			LDR r0, =SET
			
;------------------condition 1------------------------------;			
			;AB
			MOV r1, #0; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax
			
			MOV r1, #1
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;Ay
			
			MOV r1, #2
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Bx
			
			MOV r1, #3
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;By
			
			SUB r5, r5, r3
			MUL r3, r5, r5
			
			SUB r4, r4, r2
			MUL r2, r4, r4
			
			ADD r2, r2, r3
			
		    MOV r11, #0x40000000
			STR r2, [r11]
			
			;AC
			MOV r1, #2; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax
			
			MOV r1, #3
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;Ay
			
			MOV r1, #6
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Bx
			
			MOV r1, #7
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;By
			
			SUB r5, r5, r3
			MUL r3, r5, r5
			
			SUB r4, r4, r2
			MUL r2, r4, r4
			
			ADD r2, r2, r3
			
		    MOV r11, #0x40000004
			STR r2, [r11]
			
			 
			;BD
			MOV r1, #0; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax
			
			MOV r1, #1
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;Ay
			
			MOV r1, #4
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Bx
			
			MOV r1, #5
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;By
			
			SUB r5, r5, r3
			MUL r3, r5, r5
			
			SUB r4, r4, r2
			MUL r2, r4, r4
			
			ADD r2, r2, r3
			
		    MOV r11, #0x40000008
			STR r2, [r11]
			
			;CD
			MOV r1, #4; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax
			
			MOV r1, #5
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;Ay
			
			MOV r1, #6
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Bx
			
			MOV r1, #7
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;By
			
			SUB r5, r5, r3
			MUL r3, r5, r5
			
			SUB r4, r4, r2
			MUL r2, r4, r4
			
			ADD r2, r2, r3
			
		    LDR r11, =0x4000000C
			STR r2, [r11]
			
		;----condition 1 part a----;
		
			MOV r6, #M
			MOV r7, #0x40000018 ;store the reference value 50 at 4000000018
			MOV r8, #50
			LDR r11, =0x40000000 ;address for the first value 
			LDR r12, =0x40000004 ;address for the second value
			MOV r9, #10
			
equal
			MOV r8, #50
			MOV r9, #10
			MOV r7, #0x40000018 ;store the reference value 50 at 4000000018
			
			LDR r0, [r11] ; value 1
			LDR r1, [r12] ; value 2
			CMP r0,r1 ;compare value 1 with value 2
			ADDEQ r12, #4 ;if value1 = value2, then compare value 1 to value 3 
			STREQ r8, [r7] ;if the two values are equal, store decimal 50 at the address 	
			STRNE r9, [r7] ;if the two values are NOT EQUAL, store decimal 10 at address
			LDREQ r8, [r7]
			LDRNE r9, [r7]
			SUBS r6, r6, #1 ;decrement by 1
			BNE equal
			
			MOV r7, #0x40000018 ;store the reference value 50 at 4000000018
			LDR r1, [r7]
			CMP r1, #50
			MOVNE r0, #0
			BLNE stop ;else stop the program, no need
			BLEQ cond2partA ;if condition satistfied check if lines are perpendicular
			
			;----condition 2 part a----;
			;is AC perpendicular to AB?; ;is BD perpendicular to AB?
			;if they are perpendicular the result should be 0;
			;xAC*xAB+yAC*yAB;
			
cond2partA	LDR r0, =SET ;OUR BD AND CD perpendicular?
			
			;BD
			MOV r1, #2; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Bx
			
			MOV r1, #3
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;By
			
			MOV r1, #6
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Dx
			
			MOV r1, #7
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;Dy
			
			SUB r8, r4, r2 ;BDx
			SUB r7, r5, r3; BDy
			
			;AB
			MOV r1, #0; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax
			
			MOV r1, #1
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;Ay
			
			MOV r1, #2
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Bx
			
			MOV r1, #3
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;By
			
			SUB r9, r4, r2 ;ABx
			SUB r10, r5, r3 ;ABy
			
			MUL r1, r8, r9
			MUL r2, r7, r10
			
			ADD r3, r1, r2
			
			MOV r2, #0x40000020 ;address where part b answer is stored
			STR r3, [r2] ;store it
			
			;now CHECK does it satisfy?
			LDR r3, [r2] ;load condition 1 part b
			MOV r4, #0

			CMP r4, r3 ;is condition 1 part b satisfied
			BLEQ cond2_2 ;if it is perpendicular we check if AC is perpendicular to AB
			MOVNE r0, #0 ;else store 0 at r0
			BLNE stop ;and stop the program

cond2_2		LDR r0, =SET ;our AC and CD perpendicular?
			
			;AC
			MOV r1, #0; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax
			
			MOV r1, #1
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;Ay
			
			MOV r1, #4
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Cx
			
			MOV r1, #5
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;Cy
			
			SUB r8, r4, r2 ;ACx
			SUB r7, r5, r3; ACy
			
			;AB
			MOV r1, #0; index
			LDR r6, [r0, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax
			
			MOV r1, #1
			LDR r6, [r0, r1, LSL #2]
			LDR r3, [r6] ;Ay
			
			MOV r1, #2
			LDR r6, [r0, r1, LSL #2]
			LDR r4, [r6] ;Bx
			
			MOV r1, #3
			LDR r6, [r0, r1, LSL #2]
			LDR r5, [r6] ;By
			
			SUB r9, r4, r2 ;ABx
			SUB r10, r5, r3 ;ABy
			
			MUL r1, r8, r9
			MUL r2, r7, r10
			
			ADD r3, r1, r2
			
			MOV r2, #0x40000020 ;address where part b answer is stored
			STR r3, [r2] ;store it
			
			;now CHECK does it satisfy?
			LDR r3, [r2] ;load condition 1 part b
			MOV r4, #0

			CMP r4, r3 ;is condition 1 part b satisfied
			MOVEQ r0, #1 ;if its satisfied then store 1 at r0
			MOVNE r0, #0 ;else store 0 at r0
			BLEQ cond2 ;if it forms a square, check if P lies within the square
			BLNE stop ;else stop the program
			
			
			;------------------condition 2------------------------------;	
			;is P inside the square or outside the square?;
			;A of Triangle = [x1(y2-y3)+x2(y3-y1)+x3(y1-y2)]/2
			;find Area of triangle
			
cond2		LDR r12, =SET
			
			;PAB
			
			MOV r1, #0; index
			LDR r6, [r12, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax ;x1
			
			MOV r1, #1
			LDR r6, [r12, r1, LSL #2]
			LDR r3, [r6] ;Ay ;y1
			
			MOV r1, #2
			LDR r6, [r12, r1, LSL #2]
			LDR r4, [r6] ;Bx ;x2
			
			MOV r1, #3
			LDR r6, [r12, r1, LSL #2]
			LDR r5, [r6] ;By ;y2
			
			MOV r1, #8
			LDR r6, [r12, r1, LSL #2]
			LDR r7, [r6] ;Px ;x3
			
			MOV r1, #9
			LDR r6, [r12, r1, LSL #2]
			LDR r8, [r6] ;Py ;y3
			
			SUB r9, r5, r8 ;y2-y3
			SUB r10, r8, r3 ;y3-y1
			SUB r11,r3,r5 ;y1-y2
			
			MUL r3, r2, r9;x1*ans
			MUL r5, r10, r4 ;x2*ans
			MUL r9, r11, r7 ;x3*ans
			
			ADD r1, r3, r5 ;BigAns1+BigAns2
			ADD r2, r9, r1 ;BigBigAns+BigAns3
			
			MOVS r3, r2
			RSBLT r3, r3, #0 ;absoloute value
			LSR r3, #1
			
			MOV r5, #0x40000000
			STR r3, [r5] ;store area 
		
	
			;PBD
			
			LDR r12, =SET
			
			MOV r1, #2; index
			LDR r6, [r12, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Bx ;x1
			
			MOV r1, #3
			LDR r6, [r12, r1, LSL #2]
			LDR r3, [r6] ;By ;y1
			
			MOV r1, #6
			LDR r6, [r12, r1, LSL #2]
			LDR r4, [r6] ;Dx ;x2
			
			MOV r1, #7
			LDR r6, [r12, r1, LSL #2]
			LDR r5, [r6] ;Dy ;y2
			
			MOV r1, #8
			LDR r6, [r12, r1, LSL #2]
			LDR r7, [r6] ;Px ;x3
			
			MOV r1, #9
			LDR r6, [r12, r1, LSL #2]
			LDR r8, [r6] ;Py ;y3
			
			SUB r9, r5, r8 ;y2-y3
			SUB r10, r8, r3 ;y3-y1
			SUB r11,r3,r5 ;y1-y2
			
			MUL r3, r2, r9;x1*ans
			MUL r5, r10, r4 ;x2*ans
			MUL r9, r11, r7 ;x3*ans
			
			ADD r1, r3, r5 ;BigAns1+BigAns2
			ADD r2, r9, r1 ;BigBigAns+BigAns3
			
			MOVS r3, r2
			RSBLT r3, r3, #0 ;absoloute value
			LSR r3, #1
			
			MOV r5, #0x40000004
			STR r3, [r5] ;store area 
			
			;PCD
			
			LDR r12, =SET
			
			MOV r1, #4; index
			LDR r6, [r12, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Cx ;x1
			
			MOV r1, #5
			LDR r6, [r12, r1, LSL #2]
			LDR r3, [r6] ;Cy ;y1
			
			MOV r1, #6
			LDR r6, [r12, r1, LSL #2]
			LDR r4, [r6] ;Dx ;x2
			
			MOV r1, #7
			LDR r6, [r12, r1, LSL #2]
			LDR r5, [r6] ;Dy ;y2
			
			MOV r1, #8
			LDR r6, [r12, r1, LSL #2]
			LDR r7, [r6] ;Px ;x3
			
			MOV r1, #9
			LDR r6, [r12, r1, LSL #2]
			LDR r8, [r6] ;Py ;y3
			
			SUB r9, r5, r8 ;y2-y3
			SUB r10, r8, r3 ;y3-y1
			SUB r11,r3,r5 ;y1-y2
			
			MUL r3, r2, r9;x1*ans
			MUL r5, r10, r4 ;x2*ans
			MUL r9, r11, r7 ;x3*ans
			
			ADD r1, r3, r5 ;BigAns1+BigAns2
			ADD r2, r9, r1 ;BigBigAns+BigAns3
			
			MOVS r3, r2
			RSBLT r3, r3, #0 ;absoloute value
			LSR r3, #1
			
			MOV r5, #0x40000008
			STR r3, [r5] ;store area 
			
			;PAC
			
			LDR r12, =SET
			
			MOV r1, #0; index
			LDR r6, [r12, r1, LSL #2] ;address of elements 
			LDR r2, [r6] ;Ax ;x1
			
			MOV r1, #1
			LDR r6, [r12, r1, LSL #2]
			LDR r3, [r6] ;Ay ;y1
			
			MOV r1, #4
			LDR r6, [r12, r1, LSL #2]
			LDR r4, [r6] ;Cx ;x2
			
			MOV r1, #5
			LDR r6, [r12, r1, LSL #2]
			LDR r5, [r6] ;Cy ;y2
			
			MOV r1, #8
			LDR r6, [r12, r1, LSL #2]
			LDR r7, [r6] ;Px ;x3
			
			MOV r1, #9
			LDR r6, [r12, r1, LSL #2]
			LDR r8, [r6] ;Py ;y3
			
			SUB r9, r5, r8 ;y2-y3
			SUB r10, r8, r3 ;y3-y1
			SUB r11,r3,r5 ;y1-y2
			
			MUL r3, r2, r9;x1*ans
			MUL r5, r10, r4 ;x2*ans
			MUL r9, r11, r7 ;x3*ans
			
			ADD r1, r3, r5 ;BigAns1+BigAns2
			ADD r2, r9, r1 ;BigBigAns+BigAns3
			
			MOVS r3, r2
			RSBLT r3, r3, #0 ;absoloute value
			LSR r3, #1
			
			MOV r5, #0x4000000C
	
			STR r3, [r5] ;store area
			
			;ADD these areas together 
			MOV r12, #0x40000000
			MOV r1, #0x40000004
			MOV r2, #0x40000008
			MOV r3, #0x4000000C
			
			LDR r4, [r12]
			LDR r5, [r1]
			LDR r6, [r2]
			LDR r7, [r3]
			
			MOV r11, #0 ;accumulator
			ADD r11, r4, r5
			ADD r11, r11, r6
			ADD r11, r11, r7 ;ANSWER: decimal value 16 (Hex: 10)
			
			MOV r1, #0x40000010
			STR r11, [r1] 
			
			;Area of square
			LDR r12, =SET
			;(Ay-Cy)*(Bx-Ax);
			
			MOV r1, #1
			LDR r6, [r12, r1, LSL #2]
			LDR r3, [r6] ;Ay
	
			MOV r1, #5
			LDR r6, [r12, r1, LSL #2]
			LDR r4, [r6] ;Cy 
			
			MOV r1, #2; index
			LDR r6, [r12, r1, LSL #2] ;address of elements 
			LDR r5, [r6] ;Bx 
		
			MOV r1, #0; index
			LDR r6, [r12, r1, LSL #2] ;address of elements 
			LDR r7, [r6] ;Ax ;x1
			
			SUB r3, r3, r4
			SUB r5, r5, r7
			MUL r9, r3, r5 ;ANSWER: decimal value 16 (10 in hexa)
			
			;are the two areas equal?;
			
			MOV r1, #0x40000010 
			LDR r11, [r1] 
			
			CMP r9, r11
			MOVEQ r2, #1 ;if both are equal then load register 2 with 1
			MOVNE r2, #0 ;if they are not equal then load register 2 with 0
			
			
stop		B stop

Ax 			DCD -2;0
Ay			DCD 2;1
Bx			DCD 2;2	
By			DCD 2;3
Cx			DCD -2;4
Cy			DCD -2;5
Dx			DCD 2;6
Dy			DCD -2;7
Px			DCD 1;8
Py			DCD 1;9

			END