# My code is R_print and WritetoFile


.data
fout:	.asciiz "ex.txt"
b0:	.byte '0'
b1:	.byte '1'
line:	.byte '\n'
.globl R_print
.globl I_print
.globl directive_print
.text
R_print: 
addi $a3, $zero, 6 #bits of opcode
jal WritetoFile
addi $sp, $sp, 4
addi $a3, $zero, 5
jal WritetoFile
addi $sp, $sp, 4
addi $a3, $zero, 5
jal WritetoFile
addi $sp, $sp, 4
addi $a3, $zero, 5
jal WritetoFile
addi $sp, $sp, 4
addi $a3, $zero, 5
jal WritetoFile
addi $sp, $sp, 4
addi $a3, $zero, 6
jal WritetoFile
addi $sp, $sp, 4
li $v0,4
la $a0, line
syscall
j ReadFile

I_print: 
lw $t9, ($sp)
addi $sp, $sp, 4
addi $a3, $zero, 6 #bits of opcode
jal WritetoFile
addi $sp, $sp, 4
addi $a3, $zero, 5
jal WritetoFile
addi $sp, $sp, 4
addi $a3, $zero, 5
jal WritetoFile
addi $sp, $sp, 4
addi $sp, $sp, -4
sw $t9, ($sp)
addi $a3, $zero, 16
jal WritetoFile
li $v0,4
la $a0, line
syscall
j ReadFile

directive_print:
addi $a3, $zero, 32 #bits for directive
jal WritetoFile
addi $sp, $sp, 4
li $v0,4
la $a0, line
syscall
j doneDirective

WritetoFile:
lw $t0, 0($sp)
move $t5, $a3

add $t4,$zero,$zero 	
add $t1, $zero,$zero
addi $t2, $zero, 1
sll $t2, $t2, 31	#MIPS can hold up to 32bits in a single reg
addi $t3, $zero, 32	#counter to go through length of int. if it gets to zero, we're done.

getbit:
and $t1, $t2, $t0
beq $t1, 0, Next 
addi $t1, $zero, 1   # indicates that the bit is 1

Next:
bgt $t3, $t5, Continue #don't print until the length of bits needed

li $v0,1
move $a0, $t1
syscall

Continue:
srl $t2, $t2, 1
addi $t3, $t3, -1
bne $t3,0, getbit

jr $ra
