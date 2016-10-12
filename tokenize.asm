.data
space: .byte ' '
NULL: .asciiz ""
endofline: .byte '\n'
comma: .byte ','
t: .byte 't'
v: .byte 'v'
dollar: .byte '$'
instruction: .space 1024
operand1: .space 1024
operand2: .space 1024
operand3: .space 1024
instructionLine: .space 1024 #Holds the instructions
.globl tokenize
.text
tokenize: 
#TESTING CHARACTERS
la $s2, endofline
lb $t4,($s2) #Load end-of-line character for testing
la $s4, NULL
lb $s5, ($s4) #Load NULL for character testing
la $s6, space
lb $t6, ($s6) #Load space character for testing

#Get info from the stack
lw $t0, ($sp)
beq $t0, 0, donet # $t0 holds the num of operands to tokenize
addi $t0, $t0, 1
addi $sp, $sp, 4
lw $s7, ($sp) #instruction line from stack
addi $sp, $sp, 4

li $t7, 0
add $t7, $t7, $s7
la $t1, instruction #Load address of array to store the instruction
li $t8, 0
li $s6, 0
add $t8, $t1, $t8
clearInstruct: #We need to clear the array that holds the instructions
beq $s6, 10, doneClear
sb $t6, ($t8)
addi $t8, $t8, 1
addi $s6, $s6, 1
j clearInstruct
doneClear:
la $t1, operand1 #Load address of array to store the instruction
li $t8, 0
li $s6, 0
add $t8, $t1, $t8
clearOp1: #We need to clear the array that holds the instructions
beq $s6, 10, doneClearop1
sb $t6, ($t8)
addi $t8, $t8, 1
addi $s6, $s6, 1
j clearOp1
doneClearop1:
la $t1, operand2 #Load address of array to store the instruction
li $t8, 0
li $s6, 0
add $t8, $t1, $t8
clearOp2: #We need to clear the array that holds the instructions
beq $s6, 10, doneClearop2
sb $t6, ($t8)
addi $t8, $t8, 1
addi $s6, $s6, 1
j clearOp2
doneClearop2:
la $t1, operand3 #Load address of array to store the instruction
li $t8, 0
li $s6, 0
add $t8, $t1, $t8
clearOp3: #We need to clear the array that holds the instructions
beq $s6, 10, doneClearop3
sb $t6, ($t8)
addi $t8, $t8, 1
addi $s6, $s6, 1
j clearOp3
doneClearop3:
la $s6, space
lb $t6, ($s6)
la $t1, instruction
li $t8, 0
add $t8, $t1, $t8
la $a1, comma
lb $s3, ($a1)
instructionloop:
lb $t9, 0($t7) #Get first char from instruction line
# If the char is a space, null branch to get first operand 
beq $t9, $t6, getop1  
beq $t9, $s5, done
beq $t9, $t4, done
sb $t9, ($t8) #Store the char into the separate instruction array
addi $t7, $t7, 1
addi $t8, $t8, 1
j instructionloop

getop1:
addi $t0, $t0, -1
beq $t0, 0, done
addi $t7, $t7, 1
la $t1, operand1 #Load address of array to store the operand
add $t8, $zero, $zero 
add $t8, $t1, $t8
op1_loop: 
lb $t9, 0($t7) #Get first char from instruction line
# If the char is a space, null, comma, or eof branch to get second operand 
beq $t9, $t6, getop2  
beq $t9, $s5, done
beq $t9, $t4, done
beq $t9, $s3, getop2 
sb $t9, 0($t8) #Store the char into the separate instruction array
addi $t7, $t7, 1
addi $t8, $t8, 1
j op1_loop

getop2:
addi $t7, $t7, 2
la $t5, operand2 #Load address of array to store the operand
li $t8, 0
add $t8, $t5, $t8
op2_loop: 
lb $t9, 0($t7) #Get first char from instruction line
# If the char is a space, null, comma, or eof branch to get third operand
beq $t9, $t6, getop3  
beq $t9, $s5, done
beq $t9, $t4, done
beq $t9, $s3, getop3 
sb $t9, 0($t8) #Store the char into the separate instruction array
addi $t7, $t7, 1
addi $t8, $t8, 1
j op2_loop
getop3:
addi $t7, $t7, 2
la $t3, operand3 #Load address of array to store the operand
li $t8, 0
add $t8, $t3, $t8
op3_loop: 
lb $t9, 0($t7) #Get first char from instruction line

# If the char is a space, null, comma, or eof branch to get third operand 
beq $t9, $t6, done  
beq $t9, $s5, done
beq $t9, $t4, done
beq $t9, $s3, done
sb $t9, ($t8) #Store the char into the separate instruction array
addi $t7, $t7, 1
addi $t8, $t8, 1
j op3_loop

done: #Finished tokenizing
la $s7, instruction
li $t7, 0
add $t7, $s7, $t7
li $s3, 0
get_sum: #Get the sum of the instruction stored in $t7
 lb $t9, ($t7) #Load a char from the instruction
 beq $t9, $t6, skipspace
 beq $t9, $t4, loadStack #If char is null branch to load the stack
 beq $t9, $s5, loadStack
 add $s3, $s3, $t9 #Store the sum in $s3
 skipspace:
 addi $t7, $t7, 1 #Increment the address
 j get_sum    

loadStack:
# Get sum of registers before loading stack so we can have a stack of numbers
load_stack_for1: #Load the stack for only 1 operand (j label)
beq $s3, 311, loadJStack
beq $s3, 106, loadJStack
bne $t0, 1, load_stack_for2
#Pop stack if memory address and its components are not needed
addi $sp, $sp, -8 # Push the stack to store 2 values
la $t7, operand1 
lb $t9, ($t7)
la $s7, dollar
lb $t8, ($s7)
bne $t9, $t8, out1
li $t8, 0
add $t8, $t8, $t7
la $s4, t
lb $s4, ($s4)
la $t3, v
lb $t3, ($t3) 
li $s7, 0
li $t9, 3
registersumloop: #Get sum of the registers
beq $t9, 0, out1sum
lb $s6, ($t8)
beq $s6, $t4, out1sum
beq $s6, $s5, out1sum
beq $s6, $t6, skipspace1
bne $s6, $s4, not_t
addi $s7, $s7, 10
not_t:
bne $s6, $t3, not_v
addi $s7, $s7, 20
not_v:
add $s7, $s6, $s7
addi $t9, $t9, -1
skipspace1:
addi $t8, $t8, 1
j registersumloop
out1: 
sw $t7, 4($sp) #Store the one operand
j lop2
out1sum:
sw $s7, 4($sp) #Store the one operand
lop2:
sw $s3, 0($sp) #Store the instruction sum
j done_loading

loadJStack:
#SECTION FOR LOADING J STACK WITH LABEL, LABEL ARRAY
#AND LABEL ARRAY INDEX
#addi $sp, $sp, -8 # Push the stack to store 2 values
la $t7, operand1 
sw $s7, 4($sp) #Store the one operand
sw $s3, 0($sp) #Store the instruction sum
#j jInstruct

load_stack_for2: #Load the stack for two operands (lw $s0, 6($t0) )
bne $t0, 2, load_stack_for3
#Pop stack if memory address and its components are not needed
addi $sp, $sp, -12
la $t7, operand2
lb $t9, ($t7)
la $s7, dollar
lb $t8, ($s7)
bne $t9, $t8, out2
li $t8, 0
add $t8, $t8, $t7
la $s4, t
lb $s4, ($s4)
la $t3, v
lb $t3, ($t3)  
li $s7, 0 
li $t9, 3
registersumloop2: #Get sum of the registers
beq $t9, 0, out2sum
lb $s6, ($t8)
beq $s6, $t4, out2sum
beq $s6, $s5, out2sum
beq $s6, $t6, skipspace2
bne $s6, $s4, not_t2
addi $s7, $s7, 10
not_t2:
bne $s6, $t3, not_v2
addi $s7, $s7, 20
not_v2:
addi $t9, $t9, -1
add $s7, $s6, $s7
skipspace2:
addi $t8, $t8, 1
j registersumloop2
out2:
sw $t7, 8($sp) #Store the second operand
j lop1
out2sum:
sw $s7, 8($sp)
lop1:
la $t7, operand1 
li $t8, 0
add $t8, $t8, $t7
la $s4, t
lb $s4, ($s4)
la $t3, v
lb $t3, ($t3)  
li $s7, 0 
li $t9, 3
registersumloop3: #Get sum of the registers
beq $t9, 0, out3
lb $s6, ($t8)
beq $s6, $t4, out3
beq $s6, $s5, out3
beq $s6, $t6, skipspace3
bne $s6, $s4, not_t3
addi $s7, $s7, 10
not_t3:
bne $s6, $t3, not_v3
addi $s7, $s7, 20
not_v3:
addi $t9, $t9, -1
add $s7, $s6, $s7
skipspace3:
addi $t8, $t8, 1
j registersumloop3
out3:
sw $s7, 4($sp) #Store the first operand
sw $s3, 0($sp) #Store the instruction sum
j done_loading

load_stack_for3: #Load the stack for three operands (add $t0, $t1, $t2)
bne $s3, 312, notBranch
bne $s3, 308, notBranch
loadBranchStack:
notBranch:
#Pop stack if memory address and its components are not needed
dontpopstack: #Dont pop the stack if the instruction is a branch
addi $sp, $sp, -16
la $t7, operand3
lb $t9, ($t7)
la $s7, dollar
lb $t8, ($s7)
bne $t9, $t8, out4
li $t8, 0
add $t8, $t8, $t7
la $s4, t
lb $s4, ($s4)
la $t3, v
lb $t3, ($t3)
li $s7, 0  
li $t9, 3
registersumloop4: #Get sum of the registers
beq $t9, 0, out4sum
lb $s6, ($t8)
beq $s6, $t4, out4sum
beq $s6, $s5, out4sum
beq $s6, $t6, skipspace4
bne $s6, $s4, not_t4
addi $s7, $s7, 10
not_t4:
bne $s6, $t3, not_v4
addi $s7, $s7, 20
not_v4:
addi $t9, $t9, -1
add $s7, $s6, $s7
skipspace4:
addi $t8, $t8, 1
j registersumloop4
out4:
sw $t7, 12($sp) #Store the third operand
j resumeBranch
out4sum:
sw $s7, 12($sp)
resumeBranch:
la $t7, operand2
li $t8, 0
add $t8, $t8, $t7
la $s4, t
lb $s4, ($s4)
la $t3, v
lb $t3, ($t3) 
li $s7, 0  
li $t9, 3
registersumloop5: #Get sum of the registers
beq $t9, 0, out5
lb $s6, ($t8)
beq $s6, $t4, out5
beq $s6, $s5, out5
beq $s6, $t6, skipspace5
bne $s6, $s4, not_t5
addi $s7, $s7, 10
not_t5:
bne $s6, $t3, not_v5
addi $s7, $s7, 20
not_v5:
addi $t9, $t9, -1
add $s7, $s6, $s7
skipspace5:
addi $t8, $t8, 1
j registersumloop5
out5:
sw $s7, 8($sp) #Store the second operand
la $t7, operand1
li $t8, 0
add $t8, $t8, $t7
la $s4, t
lb $s4, ($s4)
la $t3, v
lb $t3, ($t3) 
li $s7, 0 
li $t9, 3
registersumloop6: #Get sum of the registers
beq $t9, 0, out6
lb $s6, ($t8)
beq $s6, $t4, out6
beq $s6, $s5, out6
beq $s6, $t6, skipspace6
bne $s6, $s4, not_t6
addi $s7, $s7, 10
not_t6:
bne $s6, $t3, not_v6
addi $s7, $s7, 20
not_v6:
addi $t9, $t9, -1
add $s7, $s6, $s7
skipspace6:
addi $t8, $t8, 1
j registersumloop6
out6:
sw $s7, 4($sp) #Store the first operand
sw $s3, 0($sp) #Store the instruction sum
done_loading: #After loading the stack jump to process instruction
j processInstruct

donet:
j ReadFile

