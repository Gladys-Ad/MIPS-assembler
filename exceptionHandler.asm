.data
#exception handler
exString: 	.asciiz  "Assembled with errors."

.globl exceptions
.text
 exceptions:
	lw $t0, 0($sp)	#pop the stack to get the  flag
	beq $t0, $zero, no_exception	#assembly was successful, play sound
	j exception

no_exception:
	la $a0, 67	#pitch
	la $a1, 1000	#duration
	la $a2, 7	#instrument, piano
	la $a3, 100	#volume
	li $v0, 33
	syscall
	la $a0, 69	#pitch
	la $a1, 1000	#duration
	la $a2, 7	#instrument, piano
	la $a3, 100	#volume
	li $v0, 33
	syscall
	la $a0, 71	#pitch
	la $a1, 1000	#duration
	la $a2, 7	#instrument, piano
	la $a3, 100	#volume
	li $v0, 33
	syscall
	la $a0, 69	#pitch
	la $a1, 1000	#duration
	la $a2, 7	#instrument, piano
	la $a3, 100	#volume
	li $v0, 33
	syscall
	la $a0, 67	#pitch
	la $a1, 1000	#duration
	la $a2, 7	#instrument, piano
	la $a3, 100	#volume
	li $v0, 33
	syscall
	
	li $v0, 10	#exit program
	syscall
	
exception:
	li $v0, 4
	la $a0, exString
	syscall
	li $v0, 10	#exit program
	syscall
	  

