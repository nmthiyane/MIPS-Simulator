#05 September 2016
#Assigment3
#MTHNTHU003

.data
	prompt:			.asciiz 	"Enter a number: \n"
	correctResults: 	.asciiz 	"It is prime \n"
	incorrectResults: 	.asciiz 	"It is not prime \n"
	number:  		.word		0
	constant:		.word		2
	counter:		.word		3

 .text 

 main:
  	#Prompting the user for the input
 	li $v0, 4
 	la $a0, prompt
 	syscall 
 	
 	#Getting the user input
 	li $v0, 5
 	syscall 
 	sw $v0, number
 	
 	#loading
 	lw $t0, number
 	lw $t1, constant
 	
 	#check if number = 2
 	beq $t0,$t1,Prime
 	
 	#division
 	div $t0,$t1
 	mfhi $t2			#saving the remainder
 	
 	beq $t2,$zero, NotPrime        # if number modulus  2=0, than not prime
 	
	whileLoop:
		lw $t3, counter
		mul $t4, $t3,$t3
		bgt $t4,$t0, Prime     # if counter*counter>number break
		
		#division
 		div $t0,$t3			#number % counter
 		mfhi $t5			#saving the remainder
 		
 		beq $t5,$zero,NotPrime		#if number %counter ==0, than not a prime
 		
 		#updating counter
 		addi $t3,$t3,2
 		sw $t3, counter
 		
 		#jump back to loop
 		j whileLoop
 		
	#not a prime
 	NotPrime:
 		li $v0,4
 		la $a0, incorrectResults
 		syscall 
 		j Exit
 		
 	#prime
 	Prime:
 		li $v0,4
 		la $a0, correctResults
 		syscall 
 		j Exit
 	
 	Exit:
 		li $v0, 10 #terminate program
 		syscall 
 		jr $ra   
 jr $ra	
 	
 	
 	
