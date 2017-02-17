.globl main

.data
	array_input: .asciiz "Please input array size: "
	read_num: .asciiz "Number: "
	unsort: .asciiz "Unsorted array: "
	space: .asciiz " "
	sort: .asciiz "Sorted array: "
	endl: .asciiz "\n"
	
.text
main:
	# $t0 = n
	# $t1 = xs
	# $t2 = ii
	# $t3 = tmp
	# $t4 = ys
	# $t5 = 4 (size of word) 
	# $t6 = x
	# $t7 = y
	# $s0 = j
	# $s1 = i
	# $s2 = temporary 
	# $s4 = array[s3]
	# $s5 = increment - 1

	la $a0, array_input
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	# allocate on heap for xs
	li $t5, 4
	mul $t3, $t0, $t5
	
	li $v0, 9
	move $a0, $t3
	syscall 
	move $t1, $v0
	
	# allocate on heap for ys
	li $t5, 4
	mul $s3, $t0, $t5
	
	li $v0, 9
	move $a0, $s3
	syscall 
	move $t4, $v0
	
	li $t2, 0
	jal input_loop
	
	li $t2, 0
	li $s1, 0
	jal for_statement
	
	la $a0, unsort
	li $v0, 4
	syscall
	
	jal print_unsort
	
	la $a0, sort
	li $v0, 4
	syscall
	
	li $t2, 0
	jal print_sort
	
	li $v0, 10
	syscall
	
input_loop: 
	subi $sp, $sp, 100 
	sw $ra, 0($sp) 
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 16($sp)
	sw $t3, 20($sp)
	sw $t4, 24($sp)
	sw $t5, 28($sp)
	sw $t6, 32($sp)
	sw $s3, 36($sp)
	
	la $a0, read_num
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t6, $v0
	
	# calculate address of $t3 + 4 * ii
	mul $t3, $t2, $t5
	add $t3, $t1, $t3
	sw $t6, 0($t3) # xs[ii] = x
	
	mul $s3, $t2, $t5
	add $s3, $t4, $s3
	sw $t6, 0($s3)
	
	addi $t2, $t2, 1
	blt $t2, $t0, input_loop	
	
	lw $s3, 36($sp)
	lw $t6, 32($sp)
	lw $t5, 28($sp)
	lw $t4, 24($sp)
	lw $t3, 20($sp)
	lw $t2, 16($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	lw $ra, 0($sp) 
	addi $sp, $sp, 100 
	
	jr $ra
	
for_statement: 
	subi $sp, $sp, 100 
	sw $ra, 0($sp) 
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 16($sp)
	sw $t3, 20($sp)
	sw $t4, 24($sp)
	sw $t5, 28($sp)
	sw $t6, 32($sp)
	sw $t7, 36($sp)
	sw $s0, 40($sp)
	sw $s1, 44($sp)
	sw $s2, 48($sp)
	sw $s3, 52($sp)
	sw $s4, 56($sp)
	sw $s5, 60($sp)
	
	move $s0, $s1
	blt $s1, $t0, isort
	
	lw $s5, 60($sp)
	lw $s4, 56($sp)
	lw $s3, 52($sp)
	lw $s2, 48($sp)
	lw $s1, 44($sp)
	lw $s0, 40($sp)
	lw $t7, 36($sp)
	lw $t6, 32($sp)
	lw $t5, 28($sp)
	lw $t4, 24($sp)
	lw $t3, 20($sp)
	lw $t2, 16($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	lw $ra, 0($sp) 
	addi $sp, $sp, 100
	
	jr $ra
	
isort: 
	# if j <= 0
	blez $s0, cont_loop
	
	# temp = array[j]
	mul $s3, $s0, $t5
	add $s3, $t4, $s3
    	lw $s2, 0($s3)
	
	subi $s5, $s0, 1
	mul $s3, $s5, $t5
	add $s3, $t4, $s3
	lw $s4, 0($s3) # array[j-1]
	
	# if array[j] >= array[j-1]
	bge $s2, $s4, cont_loop
	
	mul $s3, $s0, $t5
	add $s3, $t4, $s3
    	sw $s4, 0($s3)
    	
    	subi $s5, $s0, 1
	mul $s3, $s5, $t5
	add $s3, $t4, $s3
	sw $s2, 0($s3)
    	
	subi $s0, $s0, 1 #j--
	
	j isort
	
cont_loop:
	addi $s1, $s1, 1
	j for_statement

print_unsort:
	subi $sp, $sp, 100 
	sw $ra, 0($sp) 
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $t3, 16($sp)
	sw $t5, 20($sp)
	sw $t6, 24($sp)
	
	# calculate address of $t3 + 4 * ii
	mul $t3, $t2, $t5
	add $t3, $t1, $t3
	lw $t6, 0($t3)
	
	move $a0, $t6
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	addi $t2, $t2, 1
	blt $t2, $t0, print_unsort
	
	la $a0, endl
	li $v0, 4
	syscall
	
	lw $t6, 24($sp)
	lw $t5, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	lw $ra, 0($sp) 
	addi $sp, $sp, 100 
	
	jr $ra
	
print_sort:
	subi $sp, $sp, 100 
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t2, 8($sp)
	sw $t4, 12($sp)
	sw $t5, 16($sp)
	sw $t7, 20($sp)
	sw $s3, 24($sp)
	
	# calculate address of $s3 + 4 * ii
	mul $s3, $t2, $t5
	add $s3, $t4, $s3
	lw $t7, 0($s3)
	
	move $a0, $t7
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	addi $t2, $t2, 1
	blt $t2, $t0, print_sort
	
	lw $s3, 24($sp)
	lw $t7, 20($sp)
	lw $t5, 16($sp)
	lw $t4, 12($sp)
	lw $t2, 8($sp)
	lw $t0, 4($sp)
	lw $ra, 0($sp) 
	addi $sp, $sp, 100 

	jr $ra	
