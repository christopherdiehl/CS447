#whenever a row/ column is only used once. Then store that column/ row
#GO STraight
			add $a0, $s3, $zero
			add $a1, $s5, $zero
			jal _getRowColumn
			
			bne $s3, $v0, LHStraightLoopRepeat
			addi $s3, $s3, 1
			addi $s4, $s4, 1
			li $t0, 1
			sb $t0, 0($s4)
			addi $s5, $s5, 1
			sb $s3, 0($s5)
			j LHstart
		LHStraightLoopRepeat:	
			sub $t0, $s3, $v0
			sub $s4, $s4, $t0
			sub $s4, $s4, $t0
			add $s3, $v0, $zero
			j LHstart
			
			
@#TURN left
			add $a0, $s3, $zero
			add $a1, $s5, $zero
			jal _getRowColumn
			
			bne $s3, $v0, LHLeftLoopRepeat
			addi $s3, $s3, 1
			addi $s4, $s4, 1
			li $t0, 2
			sb $t0, 0($s4)
			addi $s5, $s5, 1
			sb $s3, 0($s5)
			j LHstart
		LHLeftLoopRepeat:	
			sub $t0, $s3, $v0
			sub $s4, $s4, $t0
			sub $s4, $s4, $t0
			add $s3, $v0, $zero
			j LHstart
			