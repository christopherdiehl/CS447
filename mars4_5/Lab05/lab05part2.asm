#Christopher Diehl
#CS 447
#Lab05 part 1 
# "Recursive Factorial"

.data
	startMsg: .asciiz "Enter a nonnegative integer: "
	errorMsg: .asciiz "Invalid integer; try again. \n"
	oMsg: .asciiz " != "

.text

Start:	addi $v0, $0, 4
	la $a0, startMsg
	 syscall
	
	addi $v0, $0, 5
	 syscall
	
	add $s0, $v0, $0
	slti $t0, $s0, 0
	
	beq $t0, 1, InvalidInput

	add $a0, $s0, $0
	jal _Fac
	add $s1, $v0, $0

	addi $v0, $0, 1
	add $a0, $s0, $0
	syscall
	
	addi $v0, $0, 4
	la $a0, oMsg
	syscall
	
	addi $v0, $0, 1
	add $a0, $s1, $0
	syscall
	
	addi $v0, $0, 10
	syscall

InvalidInput: addi $v0, $0, 4
	      la $a0, errorMsg
	      syscall
	      j Start	
#factorial method
#recursive
#number put into $a0
#number expelled in $v0
#_Fac

	_Fac:
		addi $sp, $sp, -8
		sw $ra, 4($sp)
		sw $a0, 0($sp)
		li $v0, 1
		beq $a0, $0, baseCase
		addi $a0, $a0, -1
		jal _Fac
		lw $a0, 0($sp)
		mul $v0, $v0, $a0
		
		
		baseCase:
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra
	