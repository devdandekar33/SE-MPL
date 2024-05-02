; factorial
section .data
msg db "Number is: "
msgsize equ $-msg
msgfact db "Factorial is: "
msgfactsize equ $-msgfact
newline db 10

section .bss
fact resb 8    				; reserve 8 bytes for fact
num resb 2

%macro print 2
mov rax,01				
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro stop 0				; this macro is to exit
mov rax,60
mov rdi,0
syscall
%endmacro

section .txt
global _start
_start:
pop rbx					;?
pop rbx					;?
pop rbx

mov [num],rbx				;mov rbx to [num]			;? cant we display rbx directly
print msg,msgsize			;now display the message no. is

print [num],2				;display [num]
mov rsi,[num]				
mov rcx,02				;set counter to 2
xor rbx,rbx				;a xor a gives 0 so rbx becomes 0h
call aToH				;call aToH procedure

mov rax,rbx				; move rbx to rax

call factP				;call factP procedure

mov rcx,08				;mov 8 to rcx
mov rdi,fact				;mov fact to rdi
xor bx,bx				;xor bx to get 00h at bx
mov ebx,eax				; mov eax to ebx
call hToA				; call hToA procedure			;? what is this used for

print newline,10			;give some space

print msgfact,msgfactsize		; print factorial is :
print fact,8				; print fact
print newline,10			; print on newline
stop					; exit code using stop macro

factP:					
dec rbx					;decrement rbx
cmp rbx,01				;compare rbx with 1
je b1					; if equal jump to b1 

cmp rbx,00				; again if rbx = 0 jump to b1
je b1
mul rbx					;rbx multiplied by al and result in ax  	;? right 
call factP				; call factP procedure

b1:ret					; b1 consist of return 				

aToH:					; aToH procedure
up1:
rol rbx,04				;rotate rbx by 4 bytes towards left
mov al,[rsi]				;mov rsi to al 
cmp al,39h				;compare al with 39h
jbe a2					;jump if below or equal
sub al,07h				;substract 07 from al

a2:
sub al,30h				;substract 30 from al
add bl,al				; add al to bl
inc rsi					; increment rsi
loop up1				; loop up1				
ret					; return

hToA:					
d:
rol ebx,04				;rotate ebx by 04 to left
mov ax,bx				;mov bx to ax
and ax,0fh				;and 0f with ax
cmp ax,09h				;compare ax with 09
jbe ii					;jump if below equal
add ax,07h				; add 07 to ax

ii:
add ax,30h				; add 30 to ax
mov [rdi],ax				; mov ax to [rdi]
inc rdi					; increment rdi
loop d					; loop to d
ret					; return 

; ----------- TO RUN -----------
    
; nasm -f elf64 <filename>.asm
; ld -o <filename> <filename>.o
; ./<filename>
