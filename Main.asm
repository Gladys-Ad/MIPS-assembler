.data
filename: .asciiz "file.txt" #Name of the file for reading
Buffer: .space 1024 #String buffer to hold the characters in the file
instructionLine: .space 1024 #Holds the instructions
space: .byte ' '
data: .asciiz "data"
di: .asciiz "last line is a directive"
text: .asciiz "text"
lastInstructflag: .word 0
directiveflag: .space 4
NULL: .asciiz ""
endofline: .byte '\n'
comma: .byte ','
period: .byte '.'
hashtag: .byte '#'
semicolon: .byte ':'
labelArray: .space 5000 #stores label name
addressArray: .word 0 #number of lines
labelArrayIndex: .word 0 #how many labels are in array
memoryAddress: .word -4 #counter variable to increment address (PC counter)
t: .byte 't'
v: .byte 'v'
.globl main
.globl ReadFile
.globl closeFile
.globl exit
.globl get_data_section
.text

main:
#OPEN FILE AND SET THE last instruction FLAG
la $t3, lastInstructflag # put address of flag into $t3
li $t2, 0            # put the index into $t2
add $t2, $t2, $t2    # double the index
add $t2, $t2, $t2    # double the index again (now 4x)
add $t1, $t2, $t3    # combine the two components of the address
li $t4, 0
sw $t4, 0($t1)  

la $t3, directiveflag # put address of flag into $t3
li $t2, 0            # put the index into $t2
add $t2, $t2, $t2    # double the index
add $t2, $t2, $t2    # double the index again (now 4x)
add $t1, $t2, $t3    # combine the two components of the address
li $t4, 0
sw $t4, 0($t1)  

OpenFile: li $v0, 13 
la $a0, filename 
li $a1, 0 
li $a2, 0 
syscall 

move $s0, $v0


#Read the file char by char in a loop 
ReadFile: 
#INCREMENT ARRAY ADDRESS
la $t3, memoryAddress # put address of memoryAdddres into $t3
li $t2, 0            # put the index into $t2
add $t2, $t2, $t2    # double the index
add $t2, $t2, $t2    # double the index again (now 4x)
add $t1, $t2, $t3    # combine the two components of the address
lw $t4, ($t1)
addi $t4, $t4, 4
sw $t4, 0($t1)  

la $t3, directiveflag # put address of flag into $t3
li $t2, 0            # put the index into $t2
add $t2, $t2, $t2    # double the index
add $t2, $t2, $t2    # double the index again (now 4x)
add $t1, $t2, $t3    # combine the two components of the address
li $t4, 0
sw $t4, 0($t1)  

la $t8, lastInstructflag #Check the flag to see if we are on last instruction
lw $t9, ($t8)
beq $t9, 1, closeFile #Close file if last instruction has been read

#Load array to hold instruction line in a register
la $s3, instructionLine
li $t0, 0 #Declare index for the number of operands + the instruction

#TESTING CHARACTERS
la $s1, hashtag
lb $t1, ($s1) #Load hashtag character for testing
la $s2, endofline
lb $t4, ($s2) #Load end-of-line character for testing
la $s4, NULL
lb $s5, ($s4) #Load NULL for character testing
la $s6, space
lb $t6, ($s6) #Load space character for testing
la $t7, period
lb $t9, ($t7) #Load period character for testing
la $s2, semicolon
lb $s1, ($s2)

li $t7, 0 #The instruction array needs to be cleared after every loop
add $t7, $s3, $t7
li $t8, 0

clearArray:
beq $t8, 50, doneClearing
sb $t6, ($t7)
addi $t7, $t7, 1
addi $t8, $t8, 1
j clearArray
doneClearing:

ReadFileLoop:
#Read a char from the file
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 1
syscall 


move $t7, $v0
slti $t8, $t7, 1 
beq $t8, 1, lastInstruct
lb $t2, Buffer #Place the char into a register
bne $t2, $t6, notspace #If char is a space increment the num of operands
addi $t0, $t0, 1
notspace:
#If char is a # (comment) ignore the rest of the line using 
# a nested loop to step over comment chars until the end of the line
bne $t2, $t1, continue
ignoreComment: 
#Read a char from the file
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 1 
syscall 

move $t7, $v0
slti $t8, $t7, 1 
beq $t8, 1, lastInstruct

lb $t2, Buffer #Place the char into a register
beq $t2, $t4, commentSkipped #go back to read file after comment is skipped over
j ignoreComment #If char is not newline then the comment has not be completely skipped
commentSkipped:
beq $t0, 0 ReadFileLoop
sb $t4, ($s3) #Store the character into array
addi $s3, $s3, 1 #Increment array address
j doneReading
continue: #The char is not in a comment line

bne $t2, $s1, notLabel # If char is a semicolon its a label
sb $t2, ($s3)
addi $s3, $s3, 1
jal labelStore
la $s3, instructionLine
j ReadFileLoop
notLabel:
directiveline:
bne $t9, $t2, skipdirective
li $t9, 1
li $t7, 0
sw $t9, directiveflag($t7)
#Read the next two chars to see if it is .data
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 1
syscall 
#Load the first char of the directive to a register
lb $t2, Buffer
sb $t2, ($s3) #Store the character into array
addi $s3, $s3, 1 #Increment array address
bne $t2, 100, ReadFileLoop
#Read the next char to see if it is .data
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 1
syscall 
#Load the second char of the directive to a register
lb $t2, Buffer
sb $t2, ($s3) #Store the character into array
addi $s3, $s3, 1 #Increment array address
bne $t2, 97, ReadFileLoop
li $t9, 2
li $t7, 0
sw $t9, directiveflag($t7)
#Skip rest of chars in .data word
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 4
syscall 

get_data_section:
la $t8, lastInstructflag #Check the flag to see if we are on last instruction
lw $t9, ($t8)
beq $t9, 1, closeFile
#Load array to hold instruction line in a register
la $s3, instructionLine
li $t0, 0 #Declare index for the number of operands + the instruction
#TESTING CHARACTERS
la $s1, hashtag
lb $t1, ($s1) #Load hashtag character for testing
la $s2, endofline
lb $t4, ($s2) #Load end-of-line character for testing
la $s4, NULL
lb $s5, ($s4) #Load NULL for character testing
la $s6, space
lb $t6, ($s6) #Load space character for testing
la $t7, period
lb $t9, ($t7) #Load period character for testing
la $s2, semicolon
lb $s1, ($s2) #Load semicolon character for testing
li $t7, 0 #The instruction array needs to be cleared after every loop
add $t7, $s3, $t7
li $t8, 0
clearArrayd:
beq $t8, 100, doneClearingd
sb $t6, ($t7)
addi $t7, $t7, 1
addi $t8, $t8, 1
j clearArrayd
doneClearingd:
li $t7, 0
lw $t9, directiveflag($t7)
li $s7, 0
directiveLoop: #Get the lines of directives in the .data section
li $t7, 0
lw $t9, directiveflag($t7)
beq $t9, 1, doneReading

li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 1
syscall 

move $t7, $v0
slti $t8, $t7, 1 
beq $t8, 1, lastdirective

lb $t2, Buffer
bne $t2, $t6, notspaced #If char is a space increment the num of operands
addi $t0, $t0, 1
notspaced:
bne $t2, $t1, continued
ignoreCommentd: 
#Read a char from the file
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 1 
syscall 

move $t7, $v0
slti $t8, $t7, 1 
beq $t8, 1, lastdirective

lb $t2, Buffer #Place the char into a register
slti $t9, $t0, 5
beq $t2, $t4, commentSkipped2 #go back to read file after comment is skipped over
j ignoreCommentd #If char is not newline then the comment has not be completely skipped
commentSkipped2:
beq $t0, 0, directiveLoop
sb $t4, ($s3) #Store the character into array
addi $s3, $s3, 1 #Increment array address
j doneReading
continued: #The char is not in a comment line
bne $t2, $s1, noLabel
jal extractLabel
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 1
syscall 
la $s3, instructionLine
j directiveLoop
noLabel:
add $s7, $t2, $s7
bne $s7, 499, not_text
la $t7, directiveflag
li $t9, 1
li $t7, 0
sw $t9, directiveflag($t7)
li $v0, 14
move $a0, $s0 
la $a1, Buffer 
li $a2, 2
syscall 
lb $t2, Buffer
move $t7, $v0
slti $t8, $t7, 1 
beq $t8, 1, lastdirective
j ReadFile
not_text:
sb $t2, ($s3) #Store the character into array
addi $s3, $s3, 1 #Increment array address
beq $t2, $t4, doneReading #If the end of line is reached tokenize instruction
beq $t2, $s5, doneReading
j directiveLoop
skipdirective:
sb $t2, ($s3) #Store the character into array
addi $s3, $s3, 1 #Increment array address
beq $t2, $t4, doneReading #If the end of line is reached tokenize instruction
beq $t2, $s5, doneReading
j ReadFileLoop
 
 doneReading:
 nospace:
 la $t5, directiveflag #Get the directive flag to see if line was a directive
 lw $t9, ($t5)
 beq $t9, 1, directives
 beq $t9, 2, directives
 beq $t0, 0, ReadFile #If line is an empty space, don't tokenize
  addi $sp, $sp, -8
  la $t7, instructionLine
  sw $t7, 4($sp) # Load the stack with the # of phrases and instructionArray                                   
  sw $t0, 0($sp)
  j tokenize #If it is an instruction jump to tokenize    
  directives:
  beq $t0, 0, get_data_section #If line is an empty space, don't tokenize
  addi $sp, $sp, -12
  la $t7, instructionLine
  sw $t7, 8($sp) # Load the stack with the instructionArray                                   
  sw $t0, 4($sp) # Load the stack with the # of phrases and instructionArray   
  sw $t9, 0($sp) # Load the stack with the flag # 2= .data section, 1 = regular directive
  j processDirectives
                                                                                                                                                     

lastInstruct:
 la $t8, lastInstructflag #If we are on the last instruction set the flag
 lw $t9, ($t8)
 beq $t9, 1, closeFile
  li $t9, 1
  sw $t9, 0($t8)
   la $t7, instructionLine
  sw $t7, 4($sp) # Load the stack with the # of phrases and instructionArray                                   
  sw $t0, 0($sp)
  j tokenize #If it is an instruction jump to tokenize    
  
  lastdirective:
  la $t8, lastInstructflag #If we are on the last instruction set the flag
  lw $t9, ($t8)
  beq $t9, 1, closeFile
  li $t9, 1
  sw $t9, 0($t8)
  addi $sp, $sp, -12
  la $t8, directiveflag
  lw $t9, ($t8)
  la $t7, instructionLine
  sw $t7, 8($sp) # Load the stack with the instructionArray                                   
  sw $t0, 4($sp) # Load the stack with the # of phrases and instructionArray   
  sw $t9, 0($sp) # Load the stack with the flag # 2= .data section, 1 = regular directive

extractLabel:
la $t9, instructionLine
li $t7, 0
add $t7, $t9, $t7
li $t8, 0
clearLabel:
beq $t8, 50, doneLabel
sb $t6, ($t7)
addi $t7, $t7, 1
addi $t8, $t8, 1
j clearLabel
doneLabel:
jr $ra

labelStore:
lw $s4, labelArrayIndex($zero)
li $s2, 0
li $t7, 0
li $t9, 0
indexCount:
beq $s4, $t9, foundIndex  #count the chars in the label array 
lb $s6, labelArray($t7)
bne $s6, $t6, notspace3
addi $t9, $t9, 1
notspace3:
addi $t7, $t7, 1
addi $s2, $s2, 1
j indexCount
foundIndex:
li $t7, 0
copyLabel:
lb $s6, instructionLine($t7)
beq $s6, $t6, skipspace4
beq $s6, $s1, donecopy
sb $s6, labelArray($s2)
addi $s2, $s2, 1
skipspace4:
addi $t7, $t7, 1
j copyLabel
donecopy:
lb $s6, space($zero)
sb $s6, labelArray($s2) 
li $t7, 0

lw $t7, memoryAddress($zero)
lw $s4, labelArrayIndex($zero)
mul $s6, $s4, 4
sw $t7, addressArray($s6)

addi $s4, $s4, 1
sw $s4, labelArrayIndex($zero)
j extractLabel

closeFile:
#Close File
li $v0, 16 
move $a0, $s0 
syscall 

exit:
addi $sp, $sp, -4
li $t0, 0
sw $t0, ($sp)
j exceptions
