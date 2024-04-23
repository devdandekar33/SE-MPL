section .data
rm db "Processor is in real mode"
rm_l equ $-rm
pm db "Processor is in protected mode"
pm_l equ $-pm
g db "GDT contents are"
g_l equ $-g
l db "LDT contents are"
l_l equ $-l
t db "Task register contents are"
t_l equ $-t
i db "IDT contents are"
i_l equ $-i
m db "Machine status word"
m_l equ $-m
col db ":"
newline db 10

section .bss
gdt resd 1
;resw 1
ldt resw 1
idt resw 1
;resw 1
tr resw 1
cr0_data resd 1
dnum_buff resb 04     			; reserve 4 byte for dnum_buff

%macro disp 2
mov rax,01
mov rdi, 01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .text
global _start
_start:

smsw eax  				;smsw-store machine status word
mov[cr0_data],eax
bt eax,0				;bit test- copies bit from register to carry flag
jc prmode				; jump if carry
disp rm,rm_l				;display real mode text
jmp next1 				;jump to next1 

prmode:					;protected mode display
disp pm,pm_l
disp newline,1

next1 :
sgdt [gdt]				; stores segment selector from gdt
sldt [ldt]				;from ldt
sidt [idt]				;from idt
str [tr]				; from task register
disp g,g_l				;display gdt

mov bx,[gdt+4]				;move to next nibble ?
call disp_num				;call disp_num subroutine

mov bx,[gdt+2]				; move to next 2bits
call disp_num				; call disp_num subroutine

disp col,1				
mov bx,[gdt]				;move bx to [gdt]
call disp_num				
disp newline,1				;display a new line

disp l,l_l				;display ldt contents
mov bx,[ldt]				;move [ldt] to bx
call disp_num
disp newline,1

disp i,i_l				;display idt contents
mov bx,[idt+1]				; move [idt] + 1 bit to bx
call disp_num

mov bx,[idt+2]
call disp_num

disp col,1
mov bx,[idt]
call disp_num
disp newline,1

disp t,t_l				; display task register
mov bx,[tr]
call disp_num				;
disp newline,1

disp m,m_l				;display machine status word text
mov bx,[cr0_data + 2]			;move msw + 2 to bx
call disp_num

mov bx,[cr0_data]			;
call disp_num
disp newline,1

exit:					; to exit the program
mov rax,60
mov rdi,0
syscall					; system call means ask system to perform various task

disp_num:				;  ?
mov esi, dnum_buff			
mov ecx,4				

up1:					    ; ?
rol bx,4				  ; rotate left by 4 bits
mov dl,bl				  ; mov contents from bl to dl
and dl,0fh				; and dl with 0016
add dl,30h				; add 30 to dl
cmp dl,39h				; compare 30 with 39
jbe skip1				  ;if below or equal go to skip1
add dl,07h				; add 07 to dl 

skip1:
mov [esi],dl				;move dl to [esi] source index registr 
inc esi					; increment esi by 1
loop up1				; uses relative addressing mode 

disp dnum_buff,4			; display dnum_buff
ret					;return 

;*****************************	to run	*************************
; nasm -f elf64 <filename>.asm     ; even elf will work
; ld -o <filename> <filename>.o
; ./<filename>
