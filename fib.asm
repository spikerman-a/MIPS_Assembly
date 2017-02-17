.globl main


.text
main: 
	# $t1 is answer
	li $v0, 5 	#read int
	syscall
	move $a0, $v0 
	
	jal fib		#call fib
	move $t1, $v0
	
	move $a0, $t1 
	li $v0, 1 	#print int
	syscall
	
	li $v0, 10 	#exit
	syscall

fib: 
	# fib(0) = 0 
	# fib(1) = 1 
	# fib(x) = fib(x-1) + fib(x-2) when x > 1
	# $t0 is x
	# $t1 is fib(x-1) (1st recursive call) & fib(x-2) (2nd recursive call)
	
	subi $sp, $sp, 100 
	sw $ra, 0($sp) 
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	
	move $t0, $a0
	li $t1, 1
	bgt $t0, $t1, fig_else
	
	# x == 1 or x == 0
	move $v0, $t0
	
	j fib_return
	
fig_else:
	# x > 1
	subi $a0, $t0, 1
	jal fib 
	move $t1, $v0
	
	subi $a0, $t0, 2
	jal fib
	move $t2, $v0
	
	add $v0, $t1, $t2
	
fib_return:
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 100
	jr $ra