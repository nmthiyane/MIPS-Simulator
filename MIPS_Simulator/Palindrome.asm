#05 September 2016
#Assigment3
#MTHNTHU003

.data
	prompt:			.asciiz 	"Enter a number: \n"
	incorrectResults: 	.asciiz 	"It is not a palindrome \n"
	correctResults: 	.asciiz 	"It is a palindrome \n"
	palindrome: 		.word  		0
	number:  		.word		0
	counter:		.word		0
	numberCopy:		.word		0
	divider:		.word		10
	
 
 
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
 	
 	#Creating a copy of the number
 	lw $t0,number
 	add $t1,$zero,$t0 	#temporarly saving the number
 	sw $t1,numberCopy	#now storing the copy of the number
 	
 	#load numberCopy and divider
 	lw $t0, numberCopy		
 	lw $t1, divider
 	
 	
 	whileLoop:
 		lw $t0, numberCopy
 		lw $t3, palindrome
 		mul $t3, $t3, $t1            # multiply numberCopy by 10
 		
 		#division
 		div $t0,$t1
 		mfhi $t2			#saving the remainder
 		mflo $t0			# saving the quatient
 		 
 		add $t3,$t3,$t2			#adding remainder to pal
 		sw $t3, palindrome		#storing the updated pal
 		sw $t0, numberCopy 	        #storing the new number copy
 		
 		beq $t0,$zero,Results		# if numberCopy <10, branch to results
 		
 		lw $6, counter
 		addi $6,$6,1
 		sw $6, counter

 		j whileLoop
 			
 	Results:
 		
 		lw $t4, palindrome		
 	        lw $t5, number 
 	        lw $t6, counter
 	        #
 	        bne $t4,$t5, NotPal
 	        addi $t7,$zero,1
 	        
 	        beq $t7,$t6,Pal   # if length =1 than it is pal
 		
 		
 		j Pal

 	NotPal:

 	#print out results
 		li $v0,4
 		la $a0, incorrectResults
 		syscall
 		j Exit
 		
 		 
 	Pal:

 	#print out results
 		li $v0,4
 		la $a0, correctResults
 		syscall 
 		
 		j Exit
 	
 	Exit:
 	li $v0, 10 #terminate program
 	syscall 
 	jr $ra      
 jr $ra
