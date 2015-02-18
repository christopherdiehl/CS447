#Chrstopher Diehl
#CS 447
.data
 startMsg: .asciiz "\nEnter an number between 0 and 9: "
 lowGuess: .asciiz "Your guess is too low."
 highGuess: .asciiz "Your guess is too high"
 correctGuess: .asciiz "\nCongratulations! You win!"
 noGuessLeft: .asciiz "\nYou lose. The number was "
 period: .asciiz "."
 
.text

#generate random number
 addi $v0, $zero, 42
 add $a0, $zero, $zero
 addi $a1, $zero, 9
 syscall
 add $s1, $zero, $a0
 
 #start loop
 Start:
  
 #stops program if user has guessed incorrectly 3 times
  beq $t4, 3, Final
 
 #prints statement message
  addi $v0, $zero, 4
  la $a0, startMsg
  syscall
  
  #reads in an integer
   addi $v0, $zero, 5
   syscall
   add $s2, $zero, $v0
   
  #determines if user input is equal to random number
   beq $s1, $s2, End
   j Determine
 
 # Determines if user input is less than or greater than random integer  
 Determine:
  slt $t0, $s2, $s1
  bne $t0, $zero, LessThan
  
  addi $v0,$zero,4
  la $a0, highGuess
  syscall
  addi $t4, $t4,1
  j Start
  
  LessThan:
   addi $v0, $zero, 4
   la $a0, lowGuess
   syscall
   addi $t4, $t4,1
   j Start
   
 #end loop which prints out final message
 End:
  addi $v0, $zero, 4
  la $a0, correctGuess
  syscall
  j Termination
 
 Final:
  addi $v0, $zero, 4
  la $a0, noGuessLeft
  syscall
  addi $v0, $zero, 1
  add $a0, $zero, $s1
  syscall
  addi $v0, $zero,4
  la $a0, period
  syscall
  
  #terminates program
  Termination:
   addi $v0, $zero, 10
   syscall
  
   
