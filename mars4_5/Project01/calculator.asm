#Christopher Diehl
#CS 447
#Project 1

.text
# LIST OF VARIABLES
#$t0= operator
#$t1= operand 1
#$t2= operand 2
#s1= sum
#t3 used for alot of conditionals
#t9= input
#t8= lcd screen

#Start of the program which will be used to reset the operands to 0
Start:
 add $t1, $zero, $zero
 add $t2, $zero, $zero
 add $t0, $zero, $zero
 add $t8, $t1, $zero
 add $t9, $zero, $zero
 

 
#State 1 code
State1:
# Determines if the user entered an operand
 beq $t9, $zero, State1
 lui $t6, 0x8000 
 xor $t9, $t6, $t9
 
 #if input was the equal button. Program displays operand one
 beq $t9, 14, Result1
 
  #code for the Clear buton
 beq $t9, 15, Start
 
 #sees if user entered an operator
 slti $t3, $t9, 10
 bne $t3, $zero, NumOp1
 
 #checks if user entered an operator
 slti $t3,$t9, 14
 bne $t3, $zero, setOp1
 
 #adds the new operand to the screen
 NumOp1:
 
 #multiplies operand1 by 10
 sll $t4, $t1,1
 sll $t5, $t1,3
 add $t1, $t5, $t4
 add $t1, $t1, $t9
 #sets register = to operand *10+input
 add $t8, $t1, $zero
 add $t9, $zero, $zero
 
 j State1
 
 #sets the operator = to input
 setOp1:
 #beq $t9, 11, Negative
 back:
 add $t0, $zero, $t9
 add $t8, $t1, $zero
 add $t9, $zero, $zero
 waiter: beq $t9, $zero, waiter
 j State2
 
 #Negative:
  #add $t0, $t9,$zero
  #bne $t1, $zero, back
  #add $t1, $zero, $zero
 
  #j back
  
   setOp:
 add $t0, $zero, $t9
 add $t8, $t1, $zero
 add $t9, $zero, $zero
 waiters: beq $t9, $zero, waiters
 j State2
 
 ###############################################################
 
 State2:
 # Determines if the user entered an operand
 beq $t9, $zero, State2
 lui $t6, 0x8000
 xor $t9, $t6, $t9
 
 #code for equal button
 beq $t9, 14, Result1
 
 #code for the Clear buton
 beq $t9, 15, Start
 
 #sees if user entered an operand
 slti $t3, $t9, 10
 bne $t3, $zero, NumOp2
 
 #checks to see if user entered an operator
 slti $t3, $t9, 14
 bne $t3, $zero, setOp
 
 NumOp2:
 sll $t4, $t2, 1
 sll $t5, $t2, 3
 add $t2, $t4, $t5
 add $t2, $t2, $t9
 
 add $t8, $t2, $zero
 add $t9, $zero, $zero
 
 j State3
 
 Result1:
 add $s1, $t1, $zero
 add $t8, $s1, $zero
 add $t9, $zero, $zero
 
 j State4
 
 ##################################################S
 State3:
  
 beq $t9, $zero, State3
 lui $t6, 0x8000
 xor $t9, $t6, $t9
 
  #code for equal button
 beq $t9, 14, Result #need to see if it works
 
 #code for the Clear buton
 beq $t9, 15, Start
 
 slti $t3, $t9, 10
 bne $t3, $zero, NumOp3
 
 slti $t3, $t9, 14
 bne $t3, $zero, setOpState3 #this needs hella work
 
 
 NumOp3: 
 sll $t4, $t2, 1
 sll $t5, $t2, 3
 add $t2, $t4, $t5
 add $t2, $t2, $t9
 
 add $t8, $t2, $zero
 add $t9, $zero, $zero
 j State3
 
 setOpState3:
 beq $t0, 10, Addition2
 beq $t0, 11, Subtraction2
 beq $t0, 12, Multiplication2
 beq $t0, 13, Division2
 
 
 Addition2:
  add $s1, $t1, $t2
  add $t8, $s1, $zero
  add $t1, $s1, $zero
  add $t2, $zero, $zero
  add $t0, $t9, $zero
  add $t9, $zero, $zero
  j State2
 
 Subtraction2:
  sub $s1, $t1, $t2
  add $t8, $s1, $zero
  add $t1, $s1, $zero
  add $t0, $t9, $zero
   add $t2, $zero, $zero
  add $t9, $zero, $zero
  j State2
 
 Multiplication2: 
  beq $t2, $zero, Zero2
  beq $t1, $zero, Zero2
  addi $t6, $zero,1
  beq $t2, $t6, One2
  add $t6, $zero, $zero
 
 li $t6, 0x0001
 and $s2, $t6, $t2
 add $s1, $zero, $zero
 add $s3, $t2, $zero
 srl $s3, $s3, 1
 sll $s3, $s3, 1
 
 beq $s2, $zero, MLoop2
 
 add $s1, $t1, $zero

  
 MLoop2:
 
 addi $t7, $t7,2
 sll $s4, $t1,  1
 add $s1, $s4, $s1
 bne $s3, $t7, MLoop2
 
 #add $s1, $t1, $s1
 
 add $t1, $s1, $zero
 add $t0, $t9, $zero
 
 add $s3, $zero, $zero
 add $s2, $zero, $zero
 add $t7, $zero, $zero
 add $t9, $zero, $zero
 add $s2, $zero, $zero
 add $s4, $zero, $zero
 add $t2, $zero, $zero
 add $t8, $s1, $zero
 
 j State2
 
  
 
 Division2:
 
  beq $t2, $zero, Zero
  beq $t1, $zero, Zero
  slt $t6, $t1, $zero
  
  beq $t6, $zero, Skip2
  sub $t1, $zero, $t1
  addi $s4, $zero, 1
  Skip2: 
  
  add $s1, $zero, $zero
  add $t7, $zero, $zero
  li $t6, 0x0001
  and $s2, $t6, $t2
  add $s1, $zero, $zero
  
 
  beq $s2, $zero, DLoop2
 
 sub $s1, $t1, $zero
 
 DLoop2:
 
 addi $t7, $t7,1
 sub $t1, $t1, $t2
 slt $s3, $t1, $t2
 beq $s3, $zero, DLoop2
 
 add $s1, $t7, $zero
 
 add $s3, $zero, $zero
 add $s2, $zero, $zero
 add $t7, $zero, $zero
 add $t9, $zero, $zero
 add $t1, $s1, $zero
 add $t0, $t9, $zero
 add $t8, $s1, $zero
 
 beq $s4, $zero, State2
 sub $s1, $zero, $s1
 add $t8, $s1, $zero
 add $t1, $s1, $zero
 add $t0, $t9, $zero
  add $t2, $zero, $zero
 
 j State2
 
 Zero2:
 add $t8, $zero, $zero
 add $s1, $zero, $zero
 add $t0, $t9, $zero
 add $t1, $s1, $zero
  add $t2, $zero, $zero
 add $t9, $zero, $zero
 j State2

 One2:
 add $s1, $t1, $zero
 add $t1, $zero, $s1
 add $t8, $s1, $zero
  add $t2, $zero, $zero
 add $t0, $t9, $zero
 add $t9, $zero, $zero
 j State2
 
  
 
 ############################################
 #####################################33
 #####################33
 Result:
 
 beq $t0, 10, Addition
 beq $t0, 11, Subtraction
 beq $t0, 12, Multiplication
 beq $t0, 13, Division
 
 
 Addition:
  add $s1, $t1, $t2
  add $t8, $s1, $zero
  add $t9, $zero, $zero
   add $t2, $zero, $zero
  j State4
 
 Subtraction:
  sub $s1, $t1, $t2
  add $t8, $s1, $zero
  add $t9, $zero, $zero
   add $t2, $zero, $zero
  j State4
 
 Multiplication: 
  beq $t2, $zero, Zero
  beq $t1, $zero, Zero
  addi $t6, $zero,1
  beq $t2, $t6, One
  add $t6, $zero, $zero
 
 li $t6, 0x0001
 and $s2, $t6, $t2
 add $s1, $zero, $zero
 add $s3, $t2, $zero
 srl $s3, $s3, 1
 sll $s3, $s3, 1
 
 beq $s2, $zero, MLoop
 
 add $s1, $t1, $zero

  
 MLoop:
 
 addi $t7, $t7,2
 sll $s4, $t1,  1
 add $s1, $s4, $s1
 bne $s3, $t7, MLoop
 
 #add $s1, $t1, $s1
 
 add $s3, $zero, $zero
 add $s2, $zero, $zero
 add $t7, $zero, $zero
 add $t9, $zero, $zero
 add $s2, $zero, $zero
 add $s4, $zero, $zero
 add $t2, $zero, $zero
 add $t8, $s1, $zero
 
 j State4
 
  
 
 Division:
 
  beq $t2, $zero, Zero
  beq $t1, $zero, Zero
  slt $t6, $t1, $zero
  
  beq $t6, $zero, Skip
  sub $t1, $zero, $t1
  addi $s4, $zero, 1
  Skip: 
  
  add $s1, $zero, $zero
  add $t7, $zero, $zero
  li $t6, 0x0001
  and $s2, $t6, $t2
  add $s1, $zero, $zero
  
 
  beq $s2, $zero, DLoop
 
 sub $s1, $t1, $zero
 
 DLoop:
 
 addi $t7, $t7,1
 sub $t1, $t1, $t2
 slt $s3, $t1, $t2
 beq $s3, $zero, DLoop
 
 add $s1, $t7, $zero
 
 add $s3, $zero, $zero
 add $s2, $zero, $zero
 add $t7, $zero, $zero
 add $t9, $zero, $zero
 add $s2, $zero, $zero
 
 add $t8, $s1, $zero
 
 beq $s4, $zero, State4
 sub $s1, $zero, $s1
 add $t8, $s1, $zero
 add $t2, $zero, $zero
 
 j State4
 
 Zero:
 add $t8, $zero, $zero
 add $s1, $zero, $zero
 add $t9, $zero, $zero
 add $t2, $zero, $zero
 j State4

 One:
 add $s1, $t1, $zero
 add $t8, $s1, $zero
 add $t9, $zero, $zero
 add $t2, $zero, $zero
 j State4
 
 ######################33
 
 State4:
 beq $t9, $zero, State4
 lui $t6, 0x8000
 xor $t9, $t6, $t9
 
 beq $t9, 15, Start
 
 beq $t9, 14, Result4
 
 slti $t3, $t9, 10
 bne $t3, $zero, NumOpState4
 
 slti $t3, $t9, 14
 bne $t3, $zero, setOpState4
 

 
 setOpState4:
 add $t0, $zero, $t9
 add $t1, $s1, $zero
 add $t2, $zero, $zero
 add $t9, $zero, $zero
 j State2
  
 Result4:
 add $t8, $s1, $zero
 add $t9, $zero, $zero
 j State4
  
 NumOpState4:
 add $t1, $t9, $zero
 add $t8, $t1, $zero
 add $t9, $zero, $zero
 j State1