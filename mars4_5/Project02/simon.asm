#CHRISTOPHER DIEHL
#CS 447
#PROJECT 2
#DUE fEB 25TH

.data
	array: .space 100
	rngSeed: .space 32

.text
#	-List Of Variables-
#	 -$s1= input
#	 -$s0= random number used to create new sound in sequence

	waitForStart:
	  add $s1, $t9, $0
	  add $t9, $0, $0
	  la $a0, array
	  clearArray:
	  lb $t5,0($a0)
	  sb $0, 0($a0)
	  addi $a0, $a0, 1
	  bne $t5, $0, clearArray
	  bne $s1, 16, waitForStart
	 
	 # ----Sets the random seed for the _getRandom Function--------
	  addi $v0, $0 , 30
	  syscall
	  
	  add $a1, $a0, $0
	  
	  addi $v0, $0, 40
	  add $a0, $zero, $zero
	  syscall 
	  
	  sw, $a1, rngSeed
	 #------sets function for random seed-------------	
	
	Start:
	
	lw $a1, rngSeed		#makes the program have the same random seed 
	jal _getRandom		#sets the random integer up
	
	add $s0, $v0, $0
	
	jal _setNewOutput
	
	add $a0, $v0, $0 	#puts new value into $a0 to pass into _PlaySequnce
	la $a1, array
	jal _playSequence
	

	add $a0, $v0, $0	#takes array adress and puts it into $a0
	#la $a0, array
	jal _userPlay
	
	j Start 
	addi $v0, $0, 10	#closes the program down
	syscall
	
	
	

# 	-SetNewOutput
#	-passed in $a0
#	-returns in $v0
#	-sets a new random output number
	
	_setNewOutput:
	
	add $t1, $a0, $0
	
	beq $t1, $0, Blue
	li $t0, 1
	beq $t1, $t0, Yellow
	li $t0, 2
	beq $t1, $t0, Green
	li $t0, 3
	beq $t1, $t0, Red
	
	Blue:
	 addi $t1, $0, 1
	 j DoneSetRandom
	
	Yellow:
	 addi $t1, $0, 2
	 j DoneSetRandom
	
	Green:
	 addi $t1, $0, 4
	 j DoneSetRandom
	
	Red:
	 addi $t1, $0, 8
	 j DoneSetRandom

	DoneSetRandom:
	add $v0, $t1, $0
	
	jr $ra

	
#	-User Play
#	- array adrress passed in $a0

	_userPlay:
	add $t1, $0, $0
	lb $t1, 0($a0)
	
	inputWait: add $t0, $0, $t9
	beq $t0, $0, inputWait
	add $t9, $0 $0
	GetInput:
	
	bne $t1, $t0, WrongInput
	add $t8, $t0, $0
	usPlayWaitForOutput: bne $t8, $0, usPlayWaitForOutput
	addi $a0, $a0, 1
	lb $t1, 0($a0)
	beq $t1, $0, Start
	j inputWait
	WrongInput:
	add $t9, $0, $0
	addi $t8, $0, 15
	j waitForStart
	
	userPlayDone:
	
	jr $ra
	
	
			

#	-Play Sequence
#	-Stores variables in array and pulls them out
#	-New Input gets put into $a0
#	- Link to arry is in $a1
# 	-Link to array gets returned in $v0
	
	_playSequence:
	 
	 add $t1, $a0, $0
	 add $t2, $0, $0
	 playSeqLoop:
	 lb $t0, 0($a1)
	 beq $t0, $0, playSequenceDone
	 add $t8, $t0, $0
	 waitForHardwareSL: bne $t8, $0, waitForHardwareSL
	 addi $a1, $a1, 1
	 addi $t2, $t2, 1
	 bne $t0, $0, playSeqLoop
	 
	 playSequenceDone:
	 sb $t1, 0($a1)
	 sub $a1, $a1, $t2
	 add $t8, $t1, $0
	 	 
	 waitForFinal: bne $t8, $0, waitForFinal
	  
	 add $v0, $a1, 0
	 jr $ra
	

#	-GetRandom
#	-RNG seed is placed in $a0
#	-Produces a random number between 0-3
#	-This is used to generate a random button
#	-Return value in $v0

	_getRandom:
	 

	
	  addi $v0, $zero, 42
 	  add $a0, $zero, $zero
 	  addi $a1, $zero, 4
 	  syscall

	  add $v0, $a0, $0
	  
	  jr $ra
	  
