.globl main

.data
	op_select: .asciiz "Select operation (+, -, *, or /): "
	first_num: .asciiz "First number: "
	second_num: .asciiz "Second number: "
	answer: .asciiz "Answer: "
	eol: .asciiz "\n"

.text
main: 
	# $t0 is operation
	# $t5 is answer
	la $a0, op_select # print "Select operation (+, -, *, or /): "
	li $v0, 4 
	syscall
	
	li $v0, 12 	# read character
	syscall
	move $t0, $v0 
	
	la $a0, eol  	# print "\n"
	li $v0, 4
	syscall
	
      	li $t1, 43 # + operation 
	li $t2, 45 # - operation
	li $t3, 42 # * operation
	li $t4, 47 # / operation
	
	# choose which operation
	beq $t0, $t1, op_add
	beq $t0, $t2, op_sub
	beq $t0, $t3, op_mult
	beq $t0, $t4, op_div
	
op_add: 
	# adds the first and second number
	# t0 is first number 
	# t1 is second number
	move $s0, $ra
      	jal get_num
      	move $ra, $s0
      	move $t0, $v1
      	move $t1, $v0
      	
      	add $v0, $t0, $t1
      	
      	j end
      	
op_sub:
	# subtracts the second number from the first number
	# t0 is first number 
	# t1 is second number
	move $s0, $ra
      	jal get_num
      	move $ra, $s0
      	move $t0, $v1
      	move $t1, $v0
      	
      	sub $v0, $t0, $t1

	j end

op_mult:
	# multiplies the first and second number
	# t0 is first number 
	# t1 is second number
	move $s0, $ra
      	jal get_num
      	move $ra, $s0
      	move $t0, $v1
      	move $t1, $v0
      	
      	mul $v0, $t0, $t1

	j end

op_div:
	# divides first number by second number
	# t0 is first number 
	# t1 is second number
	move $s0, $ra
      	jal get_num
      	move $ra, $s0
      	move $t0, $v1
      	move $t1, $v0
      	
      	div $v0, $t0, $t1

	j end
	
get_num:
	# gets the first and second number from user
	# $v1 is first number 
	# $v0 is second number 

	la $a0, first_num # print "First number: "
	li $v0, 4 
	syscall
	
	li $v0, 5 	# read int
	syscall
	move $v1, $v0
	
	la $a0, second_num # print "Second number: "
	li $v0, 4 
	syscall
	
	li $v0, 5   	# read int
	syscall
	
	jr $ra
	
end: 
	move $t5, $v0
	
	la $a0, answer	# print "Answer: "
	li $v0, 4 
	syscall
	
	move $a0, $t5 	# print int answer
	li $v0, 1
	syscall
	
	li $v0, 10 	# exit
	syscall


