section .data
msg :db"Positive Numbers", 10,13
msglen equ $-msg

msg1 :db"Negative Numbers", 10,13
msg1len equ $-msg1

msg2 :db"Numbers in array"
msg2len equ $-msg2


nmsg :db"", 10,13
nmsglen equ $-nmsg

;n equ 5

array db -0000000000000000h,-0000000000000010h,000000000000010h,-000000000000001h,-0000000000000000h

section .bss
n resb 1
%macro display 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

result resb 16
pcount resb 1
ncount resb 1


section .text
global _start
 	_start:
 	display msg2,msg2len
 	mov byte[n],05h			;counter for array
 	mov rbp,array				;rbp points to array
 b1:	mov al,[rbp]				;mov array pointer to al
 	call Display				;call display procedure
 	inc rbp					;increment pointer
 	;loop b1
 	dec byte[n]
 	jnz b1
 	
 	mov byte[n],05
 	mov rsi,array				;set array pointer to rsi(source index)
	mov byte[pcount],00h			;set pcount to 0
 	mov byte[ncount],00h			;set ncount to 0
 	
 back: mov al,byte[rsi]				;mov first element of array to al
       cmp al,0					;compare al with 0
       jg positive
       inc byte[ncount]				; if al<0 ncount
       jmp next
       
       
positive:inc byte[pcount]
   next:inc rsi					;increment rsi
	dec byte[n]
	jnz back
	
	display msg,msglen		
	mov al,byte[pcount]		;move value in pcount to al
	call Display
	
	display msg1,msg1len
	mov al,byte[ncount]
	call Display
 	
 	exit
