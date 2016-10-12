.data
address: .word 268500992
parathesis: .byte '"'
space: .byte ' '
NULL: .asciiz ""
endofline: .byte '\n'
comma: .byte ','

.globl processDirectives
.globl doneDirective
.text
processDirectives:

	# Pop the stack with the number of phrases and the directive line
	lw $s3, ($sp) #Flag variable to see if we are in the .data. section
              # If $s2 = 2, we are in the .data section
              # If $s2 = 1, we are not in the .data section

	# Pop the stack with the number of phrases and the directive line
	addi $sp, $sp, 4 
	lw $t0, ($sp)
	addi $sp, $sp, 4
	lw $s7, ($sp) #Line containing the whole directive
	addi $sp, $sp 4


	beq $t0, 0, doneDirective # $t0 holds the num of operands to tokenize
	li $t7, 0
	add $t7, $t7, $s7

	#Chars for character testing
	la $s6, space	
	lb $t6, ($s6)		#$t6 contains space
	la $s6, endofline	
	lb $s5, ($s6)		#$t5 contains endofline
	la $s6, NULL
	lb $t4, ($s6)		#$t4 contrains null
	li $t8, 0
	add $t8, $t1, $t8
	li $s4, 0
directiveloop:
	lb $t9, 0($t7) #Get first char from directive line
# If the char is a space, null branch to get first operand 
	beq $t9, $t6, getDirective  
	beq $t9, $s5, doneDirective
	beq $t9, $t4, doneDirective
	add $s4, $t9, $s4 #Sum the chars in the directive
	addi $t7, $t7, 1
	addi $t8, $t8, 1
	j directiveloop

getDirective:
	addi $t7, $t7, 1 #now the address is pointing at the data to allocate
# Sums of all the directives to compare
asciiz:
	beq $s4, 689, characterCounter
	beq $s4, 567, characterCounter
	j byte

characterCounter:
	lb $t1, parathesis
	lb $t4, NULL
	add $t2, $zero, $zero	#set $t2 to be a counter

findString:
	lb $t0, 0($t7)
	addi $t7, $t7, 1
	bne $t0, $t1, findString #loop until it finds the begining of the string

stringfound:
	beq $t0, $t1, loop_done	#loop done when " is found
	beq $t0, $t4, loop_done #loop done when reaches null
	beq $t0, $t5, loop_done	#loop done when reaches end of line
	addi $t2, $t2, 1		#update counter
	j stringfound	
			#loops back if null or " weren't incountered
loop_done:
	beq $s4, 567, ascii_done	#if ascii, branch to add address
	addi $t2, $t2, 1	#update for asciiz storing the null terminator on the string
	j ascii_done

ascii_done:
	lw $t0, address
	add $t0, $t0, $t2 		#updates the address to store each character
	sw $t0, address			#stores new current address for later
        sw $t0, 0($sp)			#stores the directive address in the stack	
	j directivePrint
byte:
	bne $s4, 482, double
	lw $t0, address		#loads the memory address for directives
	addi $t0, $t0, 1
	addi $sp, $sp, -4	#makes room in the stack for one item
	sw $t0, address 	#stores the updates address into memory
	sw $t0, 0($sp)		#stores the directive address in the stack
	j directivePrint

double:
	bne $s4, 681, float
	lw $t0, address		#loads the memory address for directives
	addi $t0, $t0, 16
	addi $sp, $sp, -4	#makes room in the stack for one item
	sw $t0, address 	#stores the updates address into memory
	sw $t0, 0($sp)		#stores the directive address in the stack
	j directivePrint

float:
	bne $s4, 580, half
	lw $t0, address		#loads the memory address for directives
	addi $t0, $t0, 16
	addi $sp, $sp, -4	#makes room in the stack for one item
	sw $t0, address 	#stores the updates address into memory
	sw $t0, 0($sp)		#stores the directive address in the stack
	j directivePrint

half:
	bne $s4, 457, space_
	lw $t0, address		#loads the memory address for directives
	addi $t0, $t0, 14
	addi $sp, $sp, -4	#makes room in the stack for one item
	sw $t0, address 	#stores the updates address into memory
	sw $t0, 0($sp)		#stores the directive address in the stack
	j directivePrint

space_: 
	bne $s4, 570, word
	addi $t7, $t7, 1
space_num:  
  	li $t4, 0  
  	li $s2, 0
  	li $t0, 10
  	li $s6, 0
 lp:         
  	lbu $t1, ($t7)       #load unsigned char from array into t1
  	blt $t1, 48, finished   #check if char is not a digit (ascii<'0')
  	bgt $t1, 57, finished   #check if char is not a digit (ascii>'9')
  	addi $t1, $t1, -48   #converts t1's ascii value to dec value
  	mul $s2, $s2, $t0    #sum *= 10
  	add $s2, $s2, $t1    #sum += array[s1]-'0'
  	addi $t7, $t7, 1     #increment array address
  	j lp                 #jump to start of loop
          #jump to start of loop 
  finished:
    	move $t0, $s2
	j directivePrint

word:
	bne $s4, 490, doneDirective
	lw $t0, address		#loads the memory address for directives
	addi $t0, $t0, 16
	addi $sp, $sp, -4	#makes room in the stack for one item
	sw $t0, address 	#stores the updates address into memory
	sw $t0, 0($sp)		#stores the directive address in the stack
	j directivePrint

error:
doneDirective:
	bne $s3, 2, notdatasection #IF flag = 2 go to .data section
	j get_data_section
notdatasection: #else go to read file
	j ReadFile

directivePrint:
	j directive_print

