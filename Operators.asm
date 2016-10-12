.data
.globl processInstruct
.text
processInstruct:
lw $t0, ($sp) # Load the integer value of the instruction from the stack
addi $sp, $sp, 4
  
   li $t2, 0 #register 1
   li $s2, 0 #register 2
   li $s6, 0 #register 3
#R-TYPE INSTRUCTIONS
Add:
bne $t0 , 297, Addu
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers #put in number of register
addi $t1,$zero,32#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Addu:
bne $t0, 414,And
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,33#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

And:
bne $t0, 307,Jr
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,36#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Jr:
bne $t0, 220,Nor
addi $t0, $zero, 1
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,8#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Nor:
bne $t0, 335,Or
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,39#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Or:
bne $t0, 225,Slt
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,37#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Slt:
bne $t0, 339,Sltu
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,42#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Sltu:
bne $t0, 456,Sll
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,43#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Sll:
bne $t0, 331,Srl
addi $t0, $zero, 2
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $sp, $sp, -12
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t2, 0($sp)
lw $s1, 8($sp) #immediate shamt
jal immediate	#returns with integer equivalent of string imm on a stack
lw $s2, 0($sp)	#immediate as shamt
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $s7, 0($sp)
sw $zero, 4($sp)
sw $s6, 8($sp)
addi $s3, $zero,0 #func
j R_print

Srl:
bne $t0, 337,Sub
addi $t0, $zero, 2
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
lw $s6, 0($sp) #rt s6
lw $s7, 4($sp) #rd s7
lw $s1, 8($sp) #immediate shamt
jal immediate	#returns with integer equivalent of string imm on a stack
lw $s2, 0($sp)	#immediate as shamt
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $s7, 0($sp)
sw $zero, 4($sp)
sw $s6, 8($sp)
addi $s3, $zero,2 #func
j R_print

Sub:
bne $t0, 330, Subu
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,34#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

Subu:
bne $t0, 447, addi_
addi $t0, $zero, 3
addi $sp, $sp, -4
sw $t0, 0($sp)
jal Registers
addi $t1,$zero,35#func
addi $t6, $zero,0#shamt
addi $sp, $sp, -24
sw $t1, 20($sp)
sw $t6, 16($sp)
sw $t2, 12($sp)
sw $s6, 8($sp)
sw $s2, 4($sp)
sw $t6, ($sp)
j R_print

#I-TYPE INSTRUCTIONS
addi_: bne $t0, 402, addiu_
addi $s3, $zero, 8 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $t2, 8($sp)
sw $s2, 4($sp)
sw $s3, 0($sp)
jal immediate
j I_print
                 
addiu_: bne $t0, 519, andi_
addi $s3, $zero, 9 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $s2, 8($sp)
sw $t2, 4($sp)
sw $s3, 0($sp)
jal immediate
j I_print
 
andi_: bne $t0, 412, beq_
addi $s3, $zero, 12 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $s2, 8($sp)
sw $t2, 4($sp)
sw $s3, 0($sp)
jal immediate
j I_print
 
beq_: bne $t0, 312, bne_
addi $s3, $zero, 4 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
li $s1, 4
addi $sp, $sp, -16
sw $t2, 12($sp)
sw $22, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp) 
j I_print 

bne_: bne $t0, 309, lbu_
addi $s3, $zero, 5 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
li $s1, 4
addi $sp, $sp, -16
sw $t2, 12($sp)
sw $22, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp) 
j I_print 
 
lbu_: bne $t0, 323, lhu_
addi $s3, $zero, 36 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print    

lhu_: bne $t0, 329, ll_
addi $s3, $zero, 37 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print   

ll_: bne $t0, 216, lui_
addi $s3, $zero, 48 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print      
 
lui_: bne $t0, 330, lw_
addi $s3, $zero, 15 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $s2, 8($sp)
sw $t2, 4($sp)
sw $s3, 0($sp)
jal immediate
j I_print
 
lw_: bne $t0, 227, ori_
addi $s3, $zero, 35 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print   
       
ori_: bne $t0, 331, slti_
addi $s3, $zero, 13 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $t2, 8($sp)
sw $s2, 4($sp)
sw $s3, 0($sp)
jal immediate
j I_print
 
slti_: bne $t0, 444, sltiu_
li $s3, 10
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $s2, 8($sp)
sw $t2, 4($sp)
sw $s3, 0($sp)
jal immediate
j I_print
 
sltiu_: bne $t0, 561, sb_
addi $s3, $zero, 11 #opcode
li $t2, 2
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -12
sw $s2, 8($sp)
sw $t2, 4($sp)
sw $s3, 0($sp)
jal immediate
j I_print

sb_: bne $t0, 213, sc_
addi $s3, $zero, 40 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print        
 
sc_: bne $t0, 214, sh_
addi $s3, $zero, 56 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print       
 
sh_: bne $t0, 219, sw_
addi $s3, $zero, 41 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print      
 
sw_: bne $t0, 234, lwc1_
addi $s3, $zero, 43 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print     
 
lwc1_: bne $t0, 375, ldc1_
addi $s3, $zero, 49 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print      

ldc1_: bne $t0, 356, swc1_
addi $s3, $zero, 53 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print     

swc1_: bne $t0, 382, sdc1_
addi $s3, $zero, 57 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print      
sdc1_: bne $t0, 363, exit_
addi $s3, $zero, 61 #opcode
li $t2, 1
addi $sp, $sp, -4
sw $t2, ($sp)
jal Registers
lw $s1, ($sp)
addi $sp, $sp, 4
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $t2, 8($sp)
sw $s3, 4($sp)
sw $s1, 0($sp)       
jal extractImmi
j I_print   

exit_:
j ReadFile

Registers:
lw $t0, ($sp)
addi $sp, $sp, 4
bne $t0, 3, tworeg
threereg:
lw $t2, ($sp)
beq $t2,218, t8
beq $t2,219, t9
j cont..
t8:
sub $t2, $t2, 194
j next1
t9:
sub $t2, $t2, 194
j next1
cont..:
bgt $t2, 219, nott
blt $t2, 209, nott
sub $t2, $t2, 202
j next1

nott:
bne $t2, 247, notra
sub $t2, $t2, 216
j next1
notra:
bne $t2, 249, notat
sub $t2, $t2, 248
j next1
notat:
bgt $t2, 223, notv
blt $t2, 222, notv
sub $t2, $t2, 220
j next1
notv:
bgt $t2, 184, nota
blt $t2, 181, nota
sub $t2, $t2,177
j next1

nota:
bgt $t2, 206, nots
blt $t2, 199, nots
sub $t2,$t2, 183
j next1

nots:
bgt $t2, 192, notk
blt $t2, 191, notk
sub $t2,$t2,165
j next1

notk:
bne $t2, 251, notgp
sub $t2,$t2,223
j next1

notgp:
bne $t2, 250, notfp
sub $t2,$t2,220
j next1
notfp:
bne $t2, 263, notz
sub $t2,$t2, 234
j next1

notz:
bne $t2,484, exceptions
sub $t2,$t2,484
j next1

next1:
addi $sp, $sp, 4
lw $s2, ($sp)
beq $s2,218, t8
beq $s2,219, t9
j cont..1
t81:
sub $s2, $s2, 194
j next2
t91:
sub $s2, $s2, 194
j next2
cont..1:
bgt $s2, 219, nott1
blt $s2, 209, nott1
sub $s2, $s2, 202
j next2

nott1:
bne $s2, 247, notra1
sub $s2, $s2, 216
j next2
notra1:
bne $s2, 249, notat1
sub $s2, $s2, 248
j next2
notat1:
bgt $s2, 223, notv1
blt $s2, 222, notv1
sub $s2, $s2, 220
j next2
notv1:
bgt $s2, 184, nota1
blt $s2, 181, nota1
sub $s2, $s2,177
j next2

nota1:
bgt $s2, 206, nots1
blt $s2, 199, nots1
sub $s2,$s2, 183
j next2

nots1:
bgt $s2, 192, notk1
blt $s2, 191, notk1
sub $s2,$s2,165
j next2

notk1:
bne $s2, 251, notgp1
sub $s2,$s2,223
j next2

notgp1:
bne $s2, 250, notfp1
sub $s2,$s2,220
j next2
notfp1:
bne $s2, 263, notz1
sub $s2,$s2, 234
j next2

notz1:
bne $s2,484, exceptions
sub $s2,$s2,484
j next2
next2:
addi $sp, $sp, 4
lw $s6, ($sp)
beq $s6,218, t82
beq $s6,219, t92
j cont..2
t82:
sub $s6, $s6, 194
j next3
t92:
sub $s6, $s6, 194
j next3
cont..2:
bgt $s6, 219, nott2
blt $s6, 209, nott2
sub $s6, $s6, 202
j next3

nott2:
bne $s6, 247, notra2
sub $s6, $s6, 216
j next3
notra2:
bne $s6, 249, notat2
sub $s6, $s6, 248
j next3
notat2:
bgt $s6, 223, notv2
blt $s6, 222, notv2
sub $s6, $s6, 220
j next3
notv2:
bgt $s6, 184, nota2
blt $s6, 181, nota2
sub $s6, $s6,177
j next3

nota2:
bgt $s6, 206, nots2
blt $s6, 199, nots2
sub $s6,$s6, 183
j next3

nots2:
bgt $s6, 192, notk2
blt $s6, 191, notk2
sub $s6,$s6,165
j next3

notk2:
bne $s6, 251, notgp2
sub $s6,$s6,223
j next3

notgp2:
bne $s6, 250, notfp2
sub $s6,$s6,220
j next3
notfp2:
bne $s6, 263, notz2
sub $s6,$s6, 234
j next3

notz2:
bne $s6,484, exceptions
sub $s6,$s6,484
j next3
next3:
j goback

tworeg: 
bne $t0, 2, onereg
lw $t2, ($sp)
beq $t2,218, t83
beq $t2,219, t93
j cont..3
t83:
sub $t2, $t2, 194
j next4
t93:
sub $t2, $t2, 194
j next4
cont..3:
bgt $t2, 219, nott3
blt $t2, 209, nott3
sub $t2, $t2, 202
j next4

nott3:
bne $t2, 247, notra3
sub $t2, $t2, 216
j next4
notra3:
bne $t2, 249, notat3
sub $t2, $t2, 248
j next4
notat3:
bgt $t2, 223, notv3
blt $t2, 222, notv3
sub $t2, $t2, 220
j next4
notv3:
bgt $t2, 184, nota3
blt $t2, 181, nota3
sub $t2, $t2,177
j next4

nota3:
bgt $t2, 206, nots3
blt $t2, 199, nots3
sub $t2,$t2, 183
j next4

nots3:
bgt $t2, 192, notk3
blt $t2, 191, notk3
sub $t2,$t2,165
j next4

notk3:
bne $t2, 251, notgp3
sub $t2,$t2,223
j next4

notgp3:
bne $t2, 250, notfp3
sub $t2,$t2,220
j next4
notfp3:
bne $t2, 263, notz3
sub $t2,$t2, 234
j next4

notz3:
bne $t2,484, exceptions
sub $t2,$t2,484
j next4

next4:
addi $sp, $sp, 4
lw $s2, ($sp)
beq $s2,218, t8
beq $s2,219, t9
j cont..4
t84:
sub $s2, $s2, 194
j next5
t94:
sub $s2, $s2, 194
j next5
cont..4:
bgt $s2, 219, nott4
blt $s2, 209, nott4
sub $s2, $s2, 202
j next5

nott4:
bne $s2, 247, notra4
sub $s2, $s2, 216
j next5
notra4:
bne $s2, 249, notat4
sub $s2, $s2, 248
j next5
notat4:
bgt $s2, 223, notv4
blt $s2, 222, notv4
sub $s2, $s2, 220
j next5
notv4:
bgt $s2, 184, nota4
blt $s2, 181, nota4
sub $s2, $s2,177
j next5

nota4:
bgt $s2, 206, nots4
blt $s2, 199, nots4
sub $s2,$s2, 183
j next5

nots4:
bgt $s2, 192, notk4
blt $s2, 191, notk4
sub $s2,$s2,165
j next5

notk4:
bne $s2, 251, notgp4
sub $s2,$s2,223
j next5

notgp4:
bne $s2, 250, notfp4
sub $s2,$s2,220
j next5
notfp4:
bne $s2, 263, notz4
sub $s2,$s2, 234
j next5

notz4:
bne $s2,484, exceptions
sub $s2,$s2,484
j next5

next5:
j goback
onereg:
bne $t0, 1, noreg
lw $t2, ($sp)
beq $t2,218, t85
beq $t2,219, t95
j cont..5
t85:
sub $t2, $t2, 194
j next6
t95:
sub $t2, $t2, 194
j next6
cont..5:
bgt $t2, 219, nott5
blt $t2, 209, nott5
sub $t2, $t2, 202
j next6

nott5:
bne $t2, 247, notra5
sub $t2, $t2, 216
j next6
notra5:
bne $t2, 249, notat5
sub $t2, $t2, 248
j next6
notat5:
bgt $t2, 223, notv5
blt $t2, 222, notv5
sub $t2, $t2, 220
j next6
notv5:
bgt $t2, 184, nota5
blt $t2, 181, nota5
sub $t2, $t2,177
j next6

nota5:
bgt $t2, 206, nots5
blt $t2, 199, nots5
sub $t2,$t2, 183
j next6

nots5:
bgt $t2, 192, notk5
blt $t2, 191, notk5
sub $t2,$t2,165
j next6

notk5:
bne $t2, 251, notgp5
sub $t2,$t2,223
j next6

notgp5:
bne $t2, 250, notfp5
sub $t2,$t2,220
j next6
notfp5:
bne $t2, 263, notz5
sub $t2,$t2, 234
j next6

notz5:
bne $t2,484, exceptions
sub $t2,$t2,484
j next6
next6:
j goback

noreg:
goback:
addi $sp, $sp, 4
jr $ra
