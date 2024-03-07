Assignment 5
section .data
    msg:db"Storing the data in array",0xA,0xD
    msglen equ $-msg
    msg1: db"Printing : ",0xA, 0xD  ;to print array
    msg1len equ $-msg1
    msg2:db"Positive numbers are ",0xA, 0xD  ;to print positive
    msg2len equ $-msg2
    msg3:db"Negative numbers are ",0xA,0xD ; to print negative
    msg3len equ $-msg3
    array db 00044230h,00000099h,00000080h,00000001h,00000021h    
section .bss
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
    result resb 20
    counter resb 1
    ncount resb 1
    pcount resb 1
section .text
global_start:
    _start:
    
   	 print msg,msglen  ;print elements in the array
   	 mov byte[counter],5   ;set counter to 5
   	 mov rbp,array      	;declaring array

    arrayprint:
   	 mov al,[rbp] ;al is lower of ax points to array
   	 call display ;display is a subroutine
   	 inc rbp ; increment to next element of array
   	 dec byte[counter] ; decrement the counter
   	 jnz arrayprint ; if not zero jump to arrayprint
   	 
   	 mov byte[counter],5   ;again set counter to 5
   	 mov rbp,array      	;declaring array
   	 
   	 mov byte[ncount],00h    ;set ncount to 5
   	 mov byte[pcount],00h    ;set pcount to 5
    
    logic:
   	 mov al, byte[rbp] ; put the pointer of rbp in al
   	 rcl al, 1    ; rotate to left with carry by 1
   	 jc go    	 ; jump to go if carry
         inc byte[pcount] ; if not carry inc pcount
   	 jmp skip  	 ; if pcount is incremented then dont increment ncount
    go:    inc byte[ncount]    ;inc ncount
    skip:    inc rbp   	 ;now set rbp to next digit
   	 dec byte[counter]    ;dec counter
   	 jnz logic    ;if counter is not zero jump to logic
   	 
   	 print msg2, msglen2 ; print the message
   	 mov al, byte[pcount] ;move the pcount to al
   	 call display ;call display subroutine
   	 print msg1, msglen1 ; print
   	 
   	 
   	 print msg3, msglen3 ; print the message of negative count
   	 mov al, byte[ncount]
   	 call display
   	 print msg1, msglen1
   	 
   	 exit
   	 
display: 	 mov rbx,rax    ;
   	 mov rdi,result ;result will be stored in rdi
   	 mov cx,16 ;set cx equal to 16
    convert:rol rbx,04 ;rotate rbx by 4
   	 mov al,bl
   	 and al,0fh ; and al with 00001111
   	 cmp al, 09h ; compare the al with 09
   	 jle add_30 ;jump to add_30 if al <=9
   	 add al,07h ;else add 07 to al
    add_30: add al, 30h ; all 30 in all cases
   	 mov [rdi], al ;move al to rdi pointer
   	 inc rdi ; increment rdi to get next result
   	 dec cx ;dec cx couter
   	 jnz convert ; jump if not zero to convert
   	 
   	 print result,16
   	 ret
   	 
   	 

    

	

