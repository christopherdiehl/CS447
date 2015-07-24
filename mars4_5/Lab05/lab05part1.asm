#Christopher Diehl
#CS 447
#Lab05 part 1 
# "Table Lookups"

.data
	names: .asciiz "steve", "john", "david", "emily" , "shannon"
	ages: .byte 49, 18, 69, 17, 30
	enterName: .asciiz "Please enter a name: "
	ageIs: .asciiz "Age is: "
	notFoundLabel: .asciiz "Not found!"
	inputString: .space 100
	
.text
	
	addi $v0, $zero, 4 	#prints out the "Please enter a string"
	la $a0, enterName
	syscall
	
	addi $v0, $zero, 8   #reads in input
	la $a0, inputString
        addi $a1, $zero, 64
        syscall
        
        la $a0, inputString
	jal _strLength
	add $t1, $v0, $0 	#takes return value of _strLength and puts it into $t1
	subi $t1, $t1, 1	#since the characters start at 0, $t1 get shifted back a position to be pointing towards \n
  
	sb $0, inputString($t1)	#puts in the null character in the right position
	la $a0, inputString     
	add $s0, $0, $0

        la $a1, names    

 notFoundLoop: 
        addi $a1, $a1, 0
        la $a0, inputString
        jal _StrEqual
	
	add $t0, $v0, $0	#return value of _strEqual
	
	
	

	beq $t0, 0, searchForAge
	beq $s0, 4, notFoundName
	
	addi $a1, $a1, 1
	addi $s0, $s0, 1
	bne $t0, 0, notFoundLoop

	
notFoundName: 	addi $v0, $zero, 4 	#prints out the "Please enter a string"
		la $a0, notFoundLabel
		syscall
	
		addi $v0, $0, 10
		 syscall

	searchForAge:
		add $a0, $s0, $0
		la $a1, ages
		jal _LookUpAge
		
		add $s0, $v0, $0
		
		addi $v0, $0, 4
		la $a0, ageIs
		syscall
		
		addi $v0, $0, 1
		add $a0, $s0, $0
		syscall
		
		addi $v0, $0, 10
		 syscall

	
  #Function to look up ages
  #non leaf
  #index in $a0
  #age array in $a1
  #return age in $v0
  
  _LookUpAge:
		li $t0, 0
		
  Start:	beq $a0, $t0, _LookUpAgeRetrieval
  		addi $a1, $a1, 1
  		addi $t0, $t0, 1
  		j Start
  	
  		_LookUpAgeRetrieval: 
  		lb $v0, 0($a1)
   		jr $ra
						
   #Function to find length of entered String
#Passes in $a0
#returns $v0			
					
 _strLength:
  
  li $t1, 0
  add $t2, $zero, $zero
  start:  		#simple incrementing loop
  lbu $t0, 0($a0)	#loads a single bit into $t0 starting at 0 then going up
  addi $a0, $a0, 1	 #counter for the string length
  addi $t2, $t2, 1
   bne $t0, $0, start 	  
  
  subi $t2, $t2, 1	#puts the index at n-1 or sets it equal to the \n character
  add $v0, $t2, $zero 	#puts the length of the string into v0
  jr $ra		#goes back to function call



#_StrEqual
#determines if userINput= arrayData
#user Input = $a0
#array = $a1
#returns an 1 if found, 0 if not found
#returned n $v0

_StrEqual:
	
	lb $t0, 0($a0)
	lb $t1, 0($a1)	
	
_strEqualLoop:	bne $t0, $t1, _StrEqualNotEqual
		addi $a0, $a0, 1
		addi $a1, $a1, 1
		lb $t0, 0($a0)
		lb $t1, 0($a1)
		beqz $t1, _StrEqualFoundDone
		j _strEqualLoop
	
	
	_StrEqualFoundDone:
		bne $t1, $t0, _StrEqualNotEqual
		add $v0, $0, $0
		jr $ra	
	
	_StrEqualNotEqual:
		_loopTilNull: beq $t1, $0, _strEqualNotEqualReturn
			addi $a1, $a1, 1
			lb $t1, 0($a1)
			j _loopTilNull
		
		_strEqualNotEqualReturn:
		addi $v0, $0, 1
		jr $ra
	
