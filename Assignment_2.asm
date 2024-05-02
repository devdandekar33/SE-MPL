section .data
	msg1 db "Enter the string: ",0xA,0xD
	msg1len equ $-msg1
	
	msg2: db "Length of string is: ",0xA,0xD
	msg2len equ $-msg2 
	
section .bss
	str1 resb 200
	result resb 200
	
	%macro exit 0			;macro for exit, can also write macro for read and write
	mov rax,60
	mov rdi,0
	syscall
	%endmacro
	
section .text
	global _start
	_start:
	
	mov rax,1
	mov rdi,1
	mov rsi,msg1
	mov rdx,msg1len
	syscall
	
	
	mov rax,0
	mov rdi,0
	mov rsi,str1
	mov rdx,200
	syscall
	
	mov rbx,rax,				;saves the return value of syscall i.e. the number of characters read
	mov rdi,result				;mov result in rdi
	mov cx,16				;set cx to 16
	
up1:
	rol rbx,04				;rotate rbx by 4 bits to left(lsb takes position of msb)
	mov al,bl				;
	and al,0fh				;and al with 0f 
	cmp al,09h				;compare with 9h 
	jg add_37
	add al,30h				;if al<=9 add 30 to it
	jmp skip
	
	add_37: add al,37h
	skip: mov[rdi],al			;mov al to [rdi] i.e. to result
	inc rdi,
	dec cx,
	jnz up1
	
	
	mov rax,1
	mov rdi,1
	mov rsi,result
	mov rdx,16
	syscall

	exit
