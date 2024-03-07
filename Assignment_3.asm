section .data
	msg1: db"Taking input into the array: ",0xA,0xD
	msg1len equ $-msg1
	
	msg2: db"Printing array: ",0xA,0xD
	msg2len equ $-msg2
	
	
   	msg3: db"Maximum element in the array: ",0xA,0xD
    	msg3len equ $-msg3
	
	result:
	
	
section .bss
	array resd 200
	counter resb 1
	max resb 10
	
	%macro exit 0
	mov rax,60
	mov rdi,0
	syscall
	%endmacro
	
	%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	%macro input 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	
section .text


global _start
	_start:
	
	print msg1 , msg1len
	
	mov rbp,array;
	mov byte[counter],5
	
	loop1: input rbp,17
	
	add rbp,17
	dec byte[counter]
	jnz loop1
	
	
	print msg2 , msg2len
	
	
	mov rbp,array;
	mov byte[counter],5
	
	loop2: print rbp,17
	
	add rbp,17
	dec byte[counter]
	jnz loop2
	
	
	mov cx,5
	mov al,0
	mov rsi,array
	back: cmp al,[rsi]
	ja go
	
	mov al,[rsi]
	go: inc rsi
	dec cx,
	jnz back 
	
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
	
	print msg3, msg3len
    	print result ,16
	
	exit
