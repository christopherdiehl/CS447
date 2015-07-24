#Christopher Diehl
#CS 447
#Maze Solver 
#8x8

.data 
	directions: .space 100			#straight =0, right=1, left =2
	coordinates: .space 100

.text
	add $t8, $t0, $zero
	add $t9, $t9, $zero

	#jal _leftHandRule
	#add $a2, $v0, $zero
	#la $a0, directions
	#jal _directBack
	
	addi $t8, $zero, 1
	addi $a0, $zero, 1

	jal _backtracking
	addi $v0, $zero, 10
	syscall
	
	
# _directBack
#takes robot back through the maze directly
#takes info stored from array
#regurtitates info and moves based on previous left hand rule movements
#goes 0-100 real quick
#ends at 0, -1
#robot is already turned around
#leaf function
#index passed in $a2
#directions in $a0
	_directBack:
	
	DBStart:	add $a0, $a0, $a2
			lb $t0, 0($a0)
			beq $t0, 0, DBEnd
			add $t8, $zero, $t0
			sub $a0, $a0, 1
			j DBStart
		
			DBEnd: 
			jr $ra

#Recursision with backtracking
#leaf Function
#goes 0-100 real quick
#$a0 - last direction / wall
#north = 0. east = 1. south = 2. west = 3 true = 5
	_backtracking:
		beq $v0, 5, BaseCase
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $ra, 0($sp)
		add $s0, $a0, $0
		
		
RWBstart:	addi $t8, $zero, 4
		nop
		add $a0, $t9, $zero
		jal _checkIfFinished
		beq $v0, 1, BaseCase
		
TryNorth:		beq $s0, 2, TryWest

			jal _isNorthWall
			bne $v0, 0, TryWest
			addi $a0, $zero, 0
			jal _backtracking
			
TryWest:		beq $s0, 1, TrySouth

			jal _isWestWall
			bne $v0, 0, TrySouth
			addi $a0, $zero, 1
			jal _backtracking
TrySouth:		beq $s0, 0, TryEast

			jal _isSouthWall
			bne $v0, 0, TryEast
			addi $a0, $zero, 2
			jal _backtracking
			
TryEast:		beq $s0, 3, callRecursive	

			jal _isEastWall
			addi $a0, $zero, 3
callRecursive:		jal _backtracking
			
		
		
		BaseCase:
		addi $v0, $zero, 5
		lw $s0, 0($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 8
		jr $ra


#isWestWall
#leaf	
	_isWestWall:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	add $t8, $zero, 4
	nop
	add $a0, $t9, $zero
	jal _isFacingNorth
	beq $v0, 1, WWN
	
	jal _isFacingEast
	beq $v0, 1, WWE
	
	jal _isFacingSouth
	beq $v0, 1 WWS
	
	jal _isFacingWest
	beq $v0, 1 WWW
	
	j WWEnd
	
	WWW:
	jal _isFrontWall
	bne $v0, 0, WWEnd
	addi $t8, $zero, 1
	j WWEnd
	
	WWS:
	jal _isRightWall
	bne $v0, 0, WWEnd
	addi $t8, $zero, 3
	addi $t8, $zero, 1
	j WWEnd
	
	WWN:
	jal _isLeftWall
	bne $v0, 0, WWEnd
	addi $t8, $zero, 2
	addi $t8, $zero, 1
	j WWEnd
	
	WWE:
	jal _isBackWall
	bne $v0, 0, WWEnd
	addi $t8, $zero, 3
	addi $t8, $zero, 3
	addi $t8, $zero, 1
	j WWEnd
	
	WWEnd:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra


#_isSouthWall
#leaf
#_isNorthWall
#leaf	
	_isSouthWall:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	add $t8, $zero, 4
	nop
	add $a0, $t9, $zero
	
	jal _isFacingNorth
	beq $v0, 1, SWN
	
	jal _isFacingEast
	beq $v0, 1, SWE
	
	jal _isFacingSouth
	beq $v0, 1 SWS
	
	jal _isFacingWest
	beq $v0, 1 SWW
	j SWEnd
	
	SWW:
	jal _isLeftWall
	bne $v0, 0, SWEnd
	addi $t8, $zero, 2
	addi $t8, $zero, 1
	j SWEnd
	
	SWS:
	jal _isFrontWall
	bne $v0, 0, SWEnd
	addi $t8, $zero, 1
	j SWEnd
	
	SWN:
	jal _isBackWall
	bne $v0, 0, SWEnd
	addi $t8, $zero, 2
	addi $t8, $zero, 2
	addi $t8, $zero, 1
	j SWEnd
	
	SWE:
	jal _isRightWall
	bne $v0, 0, SWEnd
	addi $t8, $zero, 3
	addi $t8, $zero, 1
	j SWEnd
	
	SWEnd:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra


#_isNorthWall
#leaf	
	_isNorthWall:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	add $t8, $zero, 4
	nop
	add $a0, $t9, $zero
	jal _isFacingNorth
	beq $v0, 1, NWN
	
	jal _isFacingEast
	beq $v0, 1, NWE
	
	jal _isFacingSouth
	beq $v0, 1 NWS
	
	jal _isFacingWest
	beq $v0, 1 NWW
	
	j NWEnd
	
	NWW:
	jal _isRightWall
	bne $v0, 0, NWEnd
	addi $t8, $zero, 3
	addi $t8, $zero, 1
	j NWEnd
	
	NWS:
	jal _isBackWall
	bne $v0, 0, NWEnd
	addi $t8, $zero, 3
	addi $t8, $zero, 3
	addi $t8, $zero, 1
	j NWEnd

	
	NWN:
	jal _isFrontWall
	bne $v0, 0, NWEnd
	addi $t8, $zero, 1
	j NWEnd

	
	NWE:
	jal _isLeftWall
	bne $v0, 0, NWEnd
	addi $t8, $zero, 2
	addi $t8, $zero, 1
	j NWEnd
	
	NWEnd:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
#_isEastWall
#leaf function

#_isNorthWall
#leaf	
	_isEastWall:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	add $t8, $zero, 4
	nop
	add $a0, $t9, $zero
	jal _isFacingNorth
	beq $v0, 1, EWN
	
	jal _isFacingEast
	beq $v0, 1, EWE
	
	jal _isFacingSouth
	beq $v0, 1 EWS
	
	jal _isFacingWest
	beq $v0, 1 EWW
	
	j EWEnd
	
	EWW:
	jal _isBackWall
	bne $v0, 0, EWEnd
	addi $t8, $zero, 3
	addi $t8, $zero, 3
	addi $t8, $zero, 1
	j EWEnd
	
	EWS:
	jal _isLeftWall
	bne $v0, 0, EWEnd
	addi $t8, $zero, 2
	addi $t8, $zero, 1
	j EWEnd
	
	EWN:
	jal _isRightWall
	bne $v0, 0, EWEnd
	addi $t8, $zero, 3
	addi $t8, $zero, 1
	j EWEnd
	
	EWE:
	jal _isFrontWall
	bne $v0, 0, EWEnd
	addi $t8, $zero, 1
	j EWEnd
	
	EWEnd:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
# _leftHandRule
#asumed start point is 0, -1
##t8 at beggining to enter maze
#leaf function
#returns index of arrays in $v0
	_leftHandRule:
		addi $sp, $sp, -28
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sw $ra, 12($sp)
		sw $s3, 16($sp)	#counter
		sw $s4, 20($sp)#directions
		sw $s5, 24($sp)#coordinates
		la $s4, directions		#string for directions
		la $s5, coordinates
		
		addi $t8, $zero, 1
LHstart:	addi $t8, $zero, 4
		nop

		add $a0, $t9, $zero
		jal _isFrontWall
		add $s1, $v0, $zero
		
		add $a0, $t9, $zero
		jal _isLeftWall
		add $s0, $v0, $zero
		
		jal _checkIfFinished
		beq $v0, 1, LHFinish
		
		beq $s0, 0, LHturnLeft
		beqz $s1, LHgoStraight
		beq $s1, 1, LHturnRight
		

		
		LHturnRight:
			add $t8, $zero, 3
			nop
			add $a0, $s3, $zero
			add $a1, $s5, $zero
			jal _getRowColumn
			
			bne $s3, $v0, LHRightLoopRepeat
			addi $s3, $s3, 1
			addi $s4, $s4, 1
			li $t0, 3
			sb $t0, 0($s4)
			addi $s5, $s5, 1
			sb $s3, 0($s5)
			j LHstart
		LHRightLoopRepeat:	
			sub $t0, $s3, $v0
			sub $s4, $s4, $t0
			sub $s4, $s4, $t0
			add $s3, $v0, $zero
			j LHstart
					
			
		LHturnLeft:
			add $t8, $zero, 2
			nop

			add $a0, $t9, $zero
			jal _isFrontWall
			add $t0, $zero, $v0
			beqz $t0, LHgoStraight
			j LHstart
			
		LHgoStraight:

			add $t8, $zero, 1
			nop
			j LHstart
			
		LHFinish : 
			   add $v0, $s3, $zero
			   lw $s2, 8($sp)
			   lw $s1, 4($sp)
			   lw $s0, 0($sp)
			   lw $ra, 12($sp)
			   lw $s3, 16($sp)
			   lw $s4, 20($sp)
			   lw $s5, 24($sp)
			   addi $sp, $sp, 28
			   addi $t8, $zero, 2
			   addi $t8, $zero, 2
				jr $ra
		
		
#check if finished
#if done then return 0 in V0
#t9 is passes in a0

	_checkIfFinished:
		addi $sp, $sp, -12
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		sw $ra, 8($sp)
		add $s0, $a0, $zero
		jal _getRow
		add $s1, $v0, $zero
		bne $s1, 7, CIFNotFin
		
		add $s0, $a0, $zero
		jal _getColumn
		bne $v0, 8, CIFNotFin
		j CIFFin
		
		CIFFin:
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 12
		addi $v0, $zero, 1
		jr $ra		
		
		CIFNotFin:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 12
		add $v0, $zero, $zero
		jr $ra
		
#getRowColumn
#gets rid of everything after duplicate coordinates
#returns the index
#index goes in $a0, put in $s0
#row column is returned in $v0
	_getRowColumn:
		addi $sp, $sp, -12
		sw $s0, 0($sp)
		sw $ra, 4($sp)
		sw $s1, 8($sp)
		add $s0, $a0, $zero
		addi $t8, $zero, 4
		add $a0, $t9, $zero
		
		jal _getRow
		
		li $t0, 10
		mult $v0, $t0
		add $s0, $v0, $zero
		addi $t8, $zero, 4	
		add $a0, $t9, $zero
		
		jal _getColumn
		
		add $v0, $v0, $s0
		add $a0, $v0, $zero
		add $a1, $s1, $zero
		jal _findDuplicatesInArray
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		lw $s1, 8($sp)
		addi $sp, $sp, 12
		
		
		jr $ra	
		
#findDuplicatesInArray
#hardcoded directions and coordinates
#non leaf function
#coordinates passed in #a0
#index in $a1
#index returned in $v0
	_findDuplicatesInArray:
		la $t0, directions
		la $t1, coordinates
		li $t3, 0
  fdiAStart:	beq $t3, $a1, findDuplicatesNotFound
  		addi $t0, $t0, 1
  		addi $t1, $t1, 1
  		addi $t3, $t3, 1
  		beq $t1, $a0, findDuplicatesFound
  		j fdiAStart
  		
  		findDuplicatesFound:
  		add $v0, $s3, $zero
  		sb $zero, 0($t0)
  		sb $zero, 0($t1)
  		jr $ra
  		
  		findDuplicatesNotFound: 
  		add $v0, $t3, $zero
   		jr $ra
		
#getRow
#$t9 goes in $a0
#columns returned in $v0
	_getRow:
		srl $t0, $a0, 24
		#li $t1, 127
		add $v0, $t0, $zero
		jr $ra

#getColumn
#$t9 goes in $a0
#columns returned in $v0
	_getColumn:
		sll $t0, $a0, 8
		srl $v0, $t0, 24
		jr $ra

# _isFacingNorth
#$t9 goes in $a0
#if 1 is returned car is facing east
#value returned in $v0
	_isFacingNorth:
		srl $t0, $a0, 11
		li $t1, 1		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra

# _isFacingSouth
#$t9 goes in $a0
#if 1 is returned car is facing east
#value returned in $v0
	_isFacingSouth:
		srl $t0, $a0, 9
		li $t1, 1		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra

# _isFacingWest
#$t9 goes in $a0
#if 1 is returned car is facing east
#value returned in $v0
	_isFacingWest:
		srl $t0, $a0, 8
		li $t1, 1		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra

# _isFacingEast
#$t9 goes in $a0
#if 1 is returned car is facing east
#value returned in $v0
	_isFacingEast:
		srl $t0, $a0, 10
		li $t1, 1		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra

#_isLeftWall
#$t9 goes in $a0
#if 1 is returned left wall is there
#value returned in $v0
	_isLeftWall:
		srl $t0, $a0, 2
		li $t1, 1		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra
	
#_isRightWall
#$t9 goes in $a0
#if 1 is returned right wall is there
#value returned in $v0
	_isRightWall:
		srl $t0, $a0, 1
		li $t1, 1 		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra

#_isFrontWall
#$t9 goes in $a0
#if 1 is returned front wall is there
#value returned in $v0
	_isFrontWall:
		srl $t0, $a0, 3
		li $t1, 1 		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra

#_isBackWall
#$t9 goes in $a0
#if 1 is returned back wall is there
#value returned in $v0
	_isBackWall:
		add $t0, $a0, $zero
		li $t1, 1 		#puts a 1 in the 4th bit
		and $v0, $t0, $t1
		jr $ra
