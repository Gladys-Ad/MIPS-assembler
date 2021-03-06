#j format instruction
.data
opcode5:	.ascii  "000101000000000100"
fout:	        .asciiz "example_jinstruction.txt"
bitString:	.space 5000 #stores the bits to print
null:		.asciiz ""
space: 		.byte ' '
address:	.word 1
label: 		.ascii "label"
labelTest:	.ascii "label"
b0:		.byte 0
b1:		.byte 1

.globl 		jOPCODE

.text
		
#should be in their code sections
jOPCODE:	
	
	#load null and space for testing later
	lb $s4, null
	lb $s5, space
	
	lb $s4, label
	lb $t2, labelTest
	
	add $t0, $zero, $zero 	#$t0 is array index
	#loop until it finds the correct label (outer loop)
findLabel:
	
	move $t1, $s4	#loads the label, if not found first time reloads the same label repeatedly
	move $s2, $t2	#loads each word from the array
characterLoop:
	#compare characters (nested loop)
	beq $t1, $s4, foundLabel #if equal null, end of label and it matches
	beq $t1, $s5, foundLabel #if equal to space, end of label and it matches
	bne $s1, $s3, loopReset #characters do not match, reset loop
	lb $s1, 1($t1) #loads each bit from the label 
	lb $s3, 1($s2)   #loads each bit from the label in the label array
	#bne $s1, $s3, error
	addi $s2, $s2, 1 #updates label from the array to point at the next character
	addi $t1, $t1, 1 #updates the label to point at the next character
	j characterLoop
	
loopReset:
	addi $t0, $t0, 1 #update array index
	addi $t2, $t2, 1 #go to the next label in the array
	j findLabel
	
foundLabel:
	
		
jPrint:
	li   $v0, 13       # system call for open file
  	la   $a0, fout     # output file name
  	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
  	move $s6, $v0      # save the file descriptor 
  	
  	li   $v0, 15       # system call for write to file
  	move $a0, $s6      # file descriptor 
  	la $a1, opcode5    #address of what you want to write
  	li   $a2, 50       # hardcoded buffer length
  	syscall            # write to file
		
printAddress:

	addi $t0, $zero, 5
	addi $sp, $sp, -4
	sw $t0, 4($sp)
	addi $a0, $zero, 14

# MY CODE below
WritetoFile: #pass the number of bits. Make sure its in $a0
	lw $t1, 0($sp) #what you want to convert is on a stack
	add $t3,$zero,$zero 	#will hold the bit value
	addi $t4, $zero, 1	#This will be what traverse through binary of user integer (through use of and instruction)
	sll $t4, $t4, 6	#MIPS can hold up to 32bits in a single reg
	addi $t5, $zero, 7	#counter to go through length of int. if it gets to zero, we're done.
getbit:
	and $t3, $t4, $t1
	beq $t3, 0, Next 
	addi $t3, $zero, 1   # indicates that the bit is 1

Next:
	bgt $t5, $t0, Continue #don't print until the length of bits needed
	beq $t3, 1, One
	la $a1, b0
	j write
One:
	la $a1, b1

write:
	li   $v0, 15       # system call for write to file
 	li   $a2, 1       # hardcoded buffer length
  	syscall            # write to file
  
Continue:
	srl $t4, $t4, 1
	addi $t5, $t5, -1
	bne $t5,0, getbit

  	li   $v0, 16       # system call for close file
 	move $a0, $s6      # file descriptor to close
  	syscall            # close file
