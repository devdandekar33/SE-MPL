section .data
	msg1: db"Taking input into the array: ",0xA,0xD
	msg1len equ $-msg1
	
	msg2: db"Printing array: ",0xA,0xD
	msg2len equ $-msg2
	
	
section .bss
	array resd 200
	counter resb 1
	
	
section .text


global _start
	_start:
	
	mov rax,1
	mov rdi,1
	mov rsi,msg1
	mov rdx,msg1len
	syscall
	
	mov rbp,array;
	mov byte[counter],5
	
	loop1: mov rax,0
	mov rdi,0
	mov rsi,rbp
	mov rdx,17
	syscall
	
	add rbp,17
	dec byte[counter]
	jnz loop1
	
	
	mov rax,1
	mov rdi,1
	mov rsi,msg2
	mov rdx,msg2len
	syscall
	
	
	mov rbp,array;
	mov byte[counter],5
	
	loop2: mov rax,1
	mov rdi,1
	mov rsi,rbp
	mov rdx,17
	syscall
	
	add rbp,17
	dec byte[counter]
	jnz loop2
	
	
	mov rax,60
	mov rdi,0
	syscall
