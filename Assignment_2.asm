section .data
	msg1 db "Enter the string: ",0xA,0xD
	msg1len equ $-msg1
	
	msg2: db "Length of string is: ",0xA,0xD
	msg2len equ $-msg2 
	
section .bss
	str1 resb 200
	result resb 200
	
	%macro exit 0
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
	
	mov rbx,rax,
	mov rdi,result
	mov cx,16
	
up1:
	rol rbx,04
	mov al,bl
	and al,0fh
	cmp al,09h
	jg add_37
	add al,30h
	jmp skip
	
	add_37: add al,37h
	skip: mov[rdi],al
	inc rdi,
	dec cx,
	jnz up1
	
	
	mov rax,1
	mov rdi,1
	mov rsi,result
	mov rdx,16
	syscall

	exit
