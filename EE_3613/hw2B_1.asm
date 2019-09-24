.data
strA: .asciiz “Original Array:\n “
strB: .asciiz “Second Array:\n: “
newline: .asciiz “\n”
space : .asciiz “ “

# This is the start of the original array.

Original:
.word 200, 270, 250, 100
.word 205, 230, 105, 235
.word 190, 95, 90, 205
.word 80, 205, 110, 215

# The next statement allocates room for the other array.
# The array takes up 4*16=64 bytes.

Second: .space 64
.align 2

.globl main
.text
main: # Your fully commented program starts here.
   li   $v0, 4
   syscall

   la   $a1, Original
   li   $s0, 16            # tail array[4] ->$s0
   li   $s1, 0             # head->$s1

loop:
   li   $v0, 5             # Load input
   syscall

   sll   $s2, $s1, 2      # shift left
   add   $s0, $a1, $s2    # $a1 + (4 x $s1) = $s0
   sw   $v0, 0($s0)       # $v0 = $s0
   addi   $s0, $s0, -1    # s0 = array[3]
   addi    $s1, $s1, 1    # s1 = array[1]
   bgtz   $s0, loop
   li   $v0, 4
   la   $a0, strB
   syscall

   li   $s0, 16
   li   $s1, 0           # Initializing array index
   addi $a2, $s1, 0      # i== a2
   addi $a3, $s1, 0      # j==a3

mattrans:
  addi $s0, $zero, 3     #s0==3
  beq $a2, $s0, frstfun1 

frstfun1:
  beq $a3, $s0, frstfun2 

frstfun2:
  jr $ra
  beq $a2, $a3, secIf    

secIf:
  addi $a2, $a2, 1
  addi $a3, $zero, 0     
  jal mattrans
  addi $a3, $a3, 1
  jal mattrans
  sll $s1, $a3, 2        
  add $s2, $s1, $a2
  sll $s3, $s2, 2
  add $s4, $a1, $s3      #array[i][j]= 1
  sll $s1, $a2, 2
  add $s2, $s1, $a3
  sll $s3, $s2, 2
  add $s5, $a1, $s3     #array[j][i]= 1
  lw $s6, 0($s5)        #s6(tmp) = array[j][i]
  lw $s7, 0($s4)        #s7 =array[i][j]
  sw $s7, 0($s5)        #array[j][i]=array[i][j];
  sw $s6, 0($s4)        #array[i][j]=tmp
  jr $ra
  li   $s0, 16
  li   $s1, 0           # initialize the array index
  b clprint

clprint:
   sll    $s2, $s1, 2
   add    $s3, $a1, $s2
   lw    $s4, 0($s3)
   li   $v0, 1
   addi    $a0, $s4, 0
   syscall

   li   $v0, 4
   la   $a0, space
   syscall

   addi    $s0, $s0, -1
   addi    $s1, $s1, 1
   sll    $s2, $s1, 2
   add    $s3, $a1, $s2

   lw    $s4, 0($s3)
   li   $v0, 1
   addi    $a0, $s4, 0
   syscall

   li   $v0, 4
   la   $a0, space
   syscall

   addi    $s0, $s0, -1
   addi    $s1, $s1, 1
   sll    $s2, $s1, 2
   add    $s3, $a1, $s2
   lw    $s4, 0($s3)
   li   $v0, 1
   addi    $a0, $s4, 0
   syscall

   li   $v0, 4
   la   $a0, space
   syscall

   addi    $s0, $s0, -1
   addi    $s1, $s1, 1
   sll    $s2, $s1, 2
   add    $s3, $a1, $s2
   lw    $s4, 0($s3)
   li   $v0, 1
   addi    $a0, $s4, 0
   syscall

   li   $v0, 4
   la   $a0, space
   syscall

   li   $v0, 4
   la   $a0, newline
   syscall

   addi    $s0, $s0, -1
   addi    $s1, $s1, 1
   bgtz    $s0, clprint
   li   $v0, 4
   la   $a0, newline
   syscall

   li    $v0, 10
   syscall

