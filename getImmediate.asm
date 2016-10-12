.data
zero0: .asciiz "0"
parenthesis: .byte '('
null: .ascii ""
immi: .space 1024
.text
.globl immediate
.globl extractImmi

extractImmi: #Extract the immediate value from a string
  lw $s1, ($sp)   
  addi $sp, $sp, 4
  la $t4, parenthesis
  lb $t6, ($t4)
   getImmi:          
   lb $t5, ($s1)
   bne $t5, $t6, notzero  
   la $s1, zero0
   j immediate                
   notzero:
      lb $t5, 1($s1)
      bne $t6, $t5, twonum  
      la $s2, immi 
      lb $t5, 0($s1)
      sb $t5, 0($s2)
      la $s1, immi
      j immediate                                  
   twonum:
      lb $t5, 2($s1)
      bne $t6, $t5, threenum  
      la $s2, immi 
      lb $t5, 0($s1)
      sb $t5, 0($s2)
      lb $t5, 1($s1)
      sb $t5, 1($s2)
      la $s1, immi
      j immediate   
   threenum:
      lb $t5, 3($s1)
      bne $t6, $t5, fournum  
      la $s2, immi 
      lb $t5, 0($s1)
      sb $t5, 0($s2)
      lb $t5, 1($s1)
      sb $t5, 1($s2)
      lb $t5, 2($s1)
      sb $t5, 2($s2)
      la $s1, immi
      j immediate   
   fournum:
     lb $t5, 4($s1)
      bne $t6, $t5, error  
      la $s2, immi 
      lb $t5, 0($s1)
      sb $t5, 0($s2)
      lb $t5, 1($s1)
      sb $t5, 1($s2)
      lb $t5, 2($s1)
      sb $t5, 2($s2)
      lb $t5, 3($s1)
      sb $t5, 3($s2)
      la $s1, immi
      j immediate   
                   
 immediate:  #Calcluate the int version of the string
  li $t4, 0  
  li $s2, 0
  li $t0, 10
  li $s6, 0
 lb $t1, ($s1)       #load unsigned char from array into t1
 bne $t1, 45, positive
 li $s6, 1 #FLAG FOR NEGATIVE VALUES
 addi $s1, $s1, 1
 lp:       
  lb $t1, ($s1)       #load unsigned char from array into t1
  positive:
  blt $t1, 48, finished   #check if char is not a digit (ascii<'0')
  bgt $t1, 57, finished   #check if char is not a digit (ascii>'9')
  addi $t1, $t1, -48   #converts t1's ascii value to dec value
  mul $s2, $s2, $t0    #sum *= 10
  add $s2, $s2, $t1    #sum += array[s1]-'0'
  addi $s1, $s1, 1     #increment array address
  j lp                 #jump to start of loop
          #jump to start of loop 
  finished:
  bne $s6, 1, positivenum
  addi $s7, $s2, 0
  add $s7, $s7, $s7
  sub $s2, $s2, $s7
  positivenum:
 addi $sp, $sp, -4
 sw $s2, ($sp) 
   error:  
   done:
 jr $ra
   
    
