section .data
msg :db 10,13,"Menu",10,13,"1.Add",10,13,"2.sub",10,13,"3.Mul",10,13,"4.Div",10,13,"5. exit",10,13,"enter choice->"
msglen equ $-msg

msg1: db "First Number",10,13
m1len equ $-msg1

msg2: dw "Second number" ,10d,13d
m2len equ $-msg2
msg3: db "Result" ,10d,13d
m3len equ $-msg3


nmsg :db"", 10,13
nmsglen equ $-nmsg

array db 0000000000000004h,0000000000000003h

section .bss
n resb 2
menu resb 1
result resb 16

%macro scall 3
mov rax,%1
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endmacro

%macro exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
global _start
 	_start:
 up:	  scall 1,msg,msglen
 	  scall 0,menu,1
 	  
 	  
 	  cmp byte[menu],1
 	  jz case1
 	  
 	  cmp byte[menu],2
 	  jz case2
 	  
 	  
 	  
 	  
 	  cmp byte[menu],'5'
 	  je case5
 	  
 	  
 	  
 	  
 	  
 	
case1: scall 1,msg1,m1len
       mov rbp, array
          
       mov al,byte[rbp]
       call Display
       
       inc rbp
       
      scall 1,msg2,m2len
      mov al,byte[rbp]
       call Display
       
       call Add
       jmp up
 	
 	
case5:  exit
 	
case2: scall 1,msg1,msglen
	mov rbp,array
	mov al,byte[rbp]
	call Display
	
	inc rbp
	scall 1,msg2,m2len
	mov al,byte[rbp]
	call Display
	
	call Sub1
	jmp up
	
Sub1:  scall 1,msg3,m3len
	mov rdx,array
	mov al,byte[rdx]
	inc rdx
	mov bl,byte[rdx]
	sub al,bl
	call Display
	   ret
 
 Add: scall 1,msg3,m3len
      mov rdx,array
      mov al,byte[rdx]
      inc rdx
      mov bl,byte[rdx]
      add al,bl
      call Display
           ret 
 	
 	
Display: 	mov rbx, rax
		mov rdi, result
		mov cx, 16
	convert:rol rbx, 04
		mov al, bl
		and al, 0fh
		cmp al, 09h
		jle add_30
		add al, 07h
	add_30: add al, 30h
		mov [rdi], al
		inc rdi
		dec cx
		jnz convert
		
		scall 1,result, 16
		scall 1,nmsg, nmsglen
		ret
