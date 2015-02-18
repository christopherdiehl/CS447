#Christopher Diehl
#Lab 04 
#Due Date: Feb 12

.data
	enterString: .asciiz "Please enter a string: \n"
	startInd: .asciiz "Specify start index: \n"
	endInd: .asciiz "Specify end Index: \n"
	subText: .asciiz "Your subscript is: "
	stringTxt: .asciiz "\nYour string has "
	charTxt: .asciiz " characters \n"
	input: .asciiz 
	output: .asciiz

.text

   addi $v0, $zero, 4 	#prints out the "Please enter a string"
   la $a0, enterString
   syscall
   
   jal _readString
   
   
   add $t1, $v0, $0
   
   addi $v0, $0, 4 	#prints out number of characters
   la $a0, stringTxt
   syscall
   
   addi $v0, $0, 1 	#prints out $t1
   add $a0, $t1, $0
   syscall
   
   addi $v0, $0, 4
   la $a0, charTxt
   syscall
   
   addi $v0, $0, 4
   la $a0, startInd
   syscall
   
   addi $v0, $0, 5
   syscall
   
   add $t2, $v0, $0	#start Index is stored in the $t2
   
   
   addi $v0, $0, 4
   la $a0, endInd
   syscall	
   
   addi $v0, $0, 5
   syscall
   
   add $t3, $v0, $0	#End Index is stored in $t3
   
   la $a0, input	#loads the input into the $a0 register for _subString
   la $a1, output
   add $a2, $t2, $0	#Takes Start index and puts it into $a2
   add $a3, $t3, $0	#Takes ENd index and puts it into $a3
  
  jal _subString
  
    add $t1, $v0, $0
   
   addi $v0, $0, 4
   la $a0, subText
   syscall
   
   addi $v0, $0, 4
   la $a0, output
   syscall
   
   addi $v0, $zero, 10
   syscall
   
   
#Function to rearrange the strings
#essentially chops off part of string
#called _subString
#calls _strLength
#back up $ra
#uses value stored in input
#a0 - address of input string
#a1 - adress of an output buffer
#start index
#a3 end index
#returns $v0 which is a copy of a1
_subString:
  
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  add $t5, $a2, $0		#start index
  add $t6, $a3, $0 		#end index
  
  la $a0, input 	#loads input into register $a0
  jal _strLength
  add $t0, $v0, $0	#takes length of string and stores it into $t0
  
  slt $t3, $t6, $t5
   beq $t3, 1, noChar
   
  slti $t3, $t5, 0
   beq $t3, 1, noChar
  
  slti $t3, $t6, 0
   beq $t3, 1, noChar
  slt $t3, $t0 , $t6
   bne $t3, 1, Skip 
    add $t6, $t0, $0
   Skip:
  add $a0, $t5, $0
  add $a1, $t6, $0
  jal _lbOutput
  
  
  Back:
  la $v0, output
  lw $ra, 0($sp)
  addi $sp, $sp, 4
 jr $ra


   noChar:
   sb $0, output($0)
   j Back
   
 #function to load the bits into the output variable
 #passes in #a0, #a1
 #returns in $v0
 _lbOutput:
  add $t0, $a0, $0 #x
  add $t1, $a1, $0 #y
  add $t4, $0, $0
  loop:
  
  	lbu $t3, input($t0)
  	sb $t3, output ($t4)
  	addi $t0, $t0, 1
  	addi $t4, $t4, 1
  	 bne $t0, $t1, loop
  	
   jr $ra
   
    
#Function to read in a string
#terminates the \n
#value stored in input
#Memory Allocated for string= 64 bits
#needs to back up ra
#needs to store word and transfer n bit to n-1 bit
   
_readString:

 addi $sp, $sp, -4	#stores $ra
 sw $ra, 0($sp)
 
   addi $v0, $zero, 8   #reads in input
   la $a0, input
   addi $a1, $zero, 64
   syscall
 
 jal _strLength
  add $t1, $v0, $0 	#takes return value of _strLength and puts it into $t1
  subi $t1, $t1, 1	#since the characters start at 0, $t1 get shifted back a position to be pointing towards \n
  
  sb $0, input($t1)	#puts in the null character in the right position
  la $a0, input 
 jal _strLength
 
  add $t1, $v0, $0
  add $v0, $t1, $0
  lw $ra, 0($sp)			#backs up $ra
  addi $sp, $sp, 4
 jr $ra 			#jumps to register $ra
   
   #Function to find length of entered String
#Passes in $a0
#returns $v0
 
 _strLength:
  
  li $t1, 0
  add $t2, $zero, $zero
  start:  		#simple incrementing loop
  lbu $t0, input($t2)	#loads a single bit into $t0 starting at 0 then going up
  addi $t2, $t2, 1	 #counter for the string length
   bne $t0, $0, start 	  
  
  subi $a0, $t2, 1	#puts the index at n-1 or sets it equal to the \n character
  add $v0, $a0, $zero 	#puts the length of the string into v0
  jr $ra		#goes back to function call
