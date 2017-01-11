#06 September 2016
#Assigment3
#MTHNTHU003

.data
	promptStart:		.asciiz 	"Enter the starting point N: \n"
	promptEnd:		.asciiz 	"Enter the ending point M: \n"
	results: 		.asciiz 	"The palindromic primes are: \n"
	newLine: 		.asciiz 	"\n"
	here:			.asciiz 	"here \n"
	palindrome: 		.word  		0
	length:			.word		0
	
	palCounter:		.word		0
	divider:		.word		10
	
	start:  		.word		0
	startCopy:		.word		0
	end:			.word		0
	
	constant:		.word		2
	primeCounter:		.word		3

.text 
 main:
 	#Prompting the user for the input
 	li $v0, 4
 	la $a0, promptStart
 	syscall 
 	
 	#Getting the user input
 	li $v0, 5
 	syscall 
 	sw $v0, start
 	
 	#Creating a copy of the number
 	lw $t0, start
 	add $t1,$zero,$t0 	#temporarly saving the number
 	sw $t1,startCopy	#now storing the copy of the number
 	
 	#Prompting the user for end
 	li $v0, 4
 	la $a0, promptEnd
 	syscall 
 	
 	#Getting the user input
 	li $v0, 5
 	syscall 
 	sw $v0, end
 	
 	#Printing the results heading
 	li $v0, 4
 	la $a0, results
 	syscall
 	
 	mainLoop:
 		
 		lw $t0, start
 		lw $t1, end
 		addi $t0,$t0, 1  	  # Add 1 so it exclude the starting number, and increament during loop
 		sw $t0,start
 		
 		bge $t0,$t1, Exit
 		sw $t0, startCopy
 	
 	palLoop:
 		lw $t0, startCopy
 		lw $t3, palindrome
 		lw $t1, divider
 		mul $t3, $t3, $t1            # multiply numberCopy by 10
 		
 		#division
 		div $t0,$t1
 		mfhi $t2			#saving the remainder
 		mflo $t0			# saving the quatient
 		 
 		add $t3,$t3,$t2			#adding remainder to pal
 		sw $t3, palindrome		#storing the updated pal
 		sw $t0, startCopy 	        #storing the new number copy
 		
 		beq $t0,$zero,Results		# if numberCopy <10, branch to results
 		
 		lw $6, length
 		addi $6,$6,1
 		sw $6, length

 		j palLoop
 			
 	Results:

 		lw $t4, palindrome		
 	        lw $t5, start 
 	        lw $t6, length
 	        
 	
 	        
 	        bne $t4,$t5, NotPal
 	        addi $t7,$zero,1
 	        
 	        beq $t7,$t6,Pal   # if length =1 than it is pal
 		j Pal

 	NotPal:
 		sw $zero, palindrome
 		j mainLoop
 				 
 	Pal:
 		#loading
 		lw $t0, start
 		lw $t1, constant
 	
 		#check if number = 2
 		beq $t0,$t1,Prime
 	
 		#division
 		div $t0,$t1
 		mfhi $t2			#saving the remainder
 	
 		beq $t2,$zero, NotPrime        # if number modulus  2=0, than not prime
 	
		primeLoop:
			lw $t3, primeCounter
			mul $t4, $t3,$t3
			bgt $t4,$t0, Prime     # if counter*counter>number break
		
			#division
 			div $t0,$t3			#number % counter
 			mfhi $t5			#saving the remainder
 			
 			beq $t5,$zero,NotPrime		#if number %counter ==0, than not a prime
 		
 			#updating counter
 			addi $t3,$t3,2
 			sw $t3, primeCounter
 		
 			#jump back to loop
 			j primeLoop
 		
		#not a prime
 		NotPrime: 
 		
 			sw $zero, palindrome
 			sw $zero, length
 			
 			addi $t1,$zero,3     #resetting prime counetr to 3
 			sw $t1, primeCounter
 			
 			j mainLoop
 		
 		#prime
 		Prime:	
 			#print palindrome
 			li $v0,1
 			lw $a0, palindrome
 			syscall 
 			
 			#print new line
 			li $v0,4
 			la $a0, newLine
 			syscall
 			
 			sw $zero, palindrome 
 			sw $zero, length
 			
 			addi $t1,$zero,3	#resetting prime counetr to 3
 			sw $t1, primeCounter
 			j mainLoop

 	Exit:
 	li $v0, 10 #terminate program
 	syscall 
 	jr $ra      
 jr $ra
