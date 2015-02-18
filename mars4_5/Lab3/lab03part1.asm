#Christopher Diehl
#Lab 03
.data
 inputMsg: .asciiz "Please enter your integer: "
 outMsg: .asciiz "\nHere is your output: "
 
.text

#Prints out opening message
addi $v0, $zero, 4
la $a0, inputMsg
syscall

#reads in integer
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

srl $t0,$t0, 15

li $s1, 0x00000007
and $t1, $t0, $s1



addi $v0, $zero, 4
la $a0, outMsg
syscall

addi $v0, $zero,1
add $a0, $zero, $t1
syscall

addi $v0, $zero, 10
syscall