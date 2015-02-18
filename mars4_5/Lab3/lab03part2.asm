.data
 errMsg: .asciiz "\nInteger must be nonnegative."
 startMsg: .asciiz "\nx^y calculator"
 xMsg: .asciiz "\nPlease enter x: "
 yMsg: .asciiz "Please enter y: "
 opMsg: .asciiz "^"
 eqMsg: .asciiz " = "
 
.text
#$t0=x
#$t2=y

 addi $v0, $zero, 4
 la $a0, startMsg
 syscall
 
 Start:
 
 addi $v0, $zero, 4
 la $a0, xMsg
 syscall
 
 addi $v0, $zero, 5
 syscall
 add $t0, $v0, $zero
 
 slti $t1, $t0, 0
 beq $t1, 1, Error
 
 #y input
 
 addi $v0, $zero, 4
 la $a0, yMsg
 syscall
 
 addi $v0, $zero, 5
 syscall
 add $t2, $v0, $zero
 
 slti $t1, $t2, 0
 beq $t1, 1, Error
 
 beq $t2, 0, None
 beq $t2,1, OneE
 add $t6, $t0, $zero
 addi $s3, $s3, 1
 
 Loop1:
 add $s4, $s0, $s0 
 addi $s3, $s3, 1
  
  Loop2:
  
   add $s0, $t6,$s0 #makes $s0 to $t0 at first 
   addi $s2,$s2, 1
  
   bne $t0, $s2, Loop2
  add $s2, $zero, $zero #resets inner loop counter
  
  add $s4, $s0, $zero #adinner loop total to the final 
  add $t6, $s0, $zero
  add $s0, $zero, $zero
  
  bne $t2, $s3, Loop1 #end of outer for loop
  

 
 Done:
 addi $v0, $zero, 1
 add $a0, $zero, $t0
 syscall
 
 addi $v0, $zero, 4
 la $a0, opMsg
 syscall
 
 addi $v0,$zero, 1
 add $a0, $zero, $t2
 syscall
 
 addi $v0, $zero, 4
 la $a0, eqMsg
 syscall
 
 addi $v0, $zero, 1
 add $a0, $zero, $s4
 syscall
 
 addi $v0, $zero, 10
 syscall
 
 
 None:
 addi $v0, $zero, 1
 add $a0, $zero, $t0
 syscall
 
 addi $v0, $zero, 4
 la $a0, opMsg
 syscall
 
 addi $v0,$zero, 1
 add $a0, $zero, $t2
 syscall
 
 addi $v0, $zero, 4
 la $a0, eqMsg
 syscall
 
 addi $v0, $zero, 1
 addi $a0, $zero, 1
 syscall
 
 addi $v0, $zero, 10
 syscall
 
 OneE:
 addi $v0, $zero, 1
 add $a0, $zero, $t0
 syscall
 
 addi $v0, $zero, 4
 la $a0, opMsg
 syscall
 
 addi $v0,$zero, 1
 add $a0, $zero, $t2
 syscall
 
 addi $v0, $zero, 4
 la $a0, eqMsg
 syscall
 
 addi $v0, $zero, 1
 add $a0, $zero, $t0
 syscall
 
 addi $v0, $zero, 10
 syscall
 
 Error:
 add $t1, $zero, $zero
 addi $v0, $zero, 4
 la $a0, errMsg
 syscall
 j Start
 
