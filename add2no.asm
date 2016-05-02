; program to input two 16bit numbers, add them and display the result 
.model small
.stack
.data
num1 dw ? 
num2 dw ?
temp db 10 dup('$')
msg1 db "Enter a number : $"
msg2 db 10,13,"Enter another number : $"
msg3 db 10,13,"Result is : $"
.code

dispm 	macro	msg
	lea dx,msg
	mov ah,09
	int 21h
endm

proc main
	mov ax,@data
	mov ds,ax

	dispm msg1

	mov bx, offset num1
	call readn

	dispm msg2

	mov bx, offset num2
	call readn

	dispm msg3
	mov ax,num1
	add ax,num2

	call printn

	mov ah,4ch
	int 21h

main	endp

proc	readn
	
	push bx

	mov ah,0Ah
	mov dx, offset temp
	int 21h

	lea si, temp
	inc si
	mov cl,[si]
	xor ch,ch
	xor ax,ax
	xor dx,dx
	inc si

read:	mov bx,10
	mul bx
	xor bh,bh
	mov bl,[si]
	sub bl,30h
	add ax,bx

	inc si
	loop read

	pop bx
	mov [bx], ax

	ret

readn	endp

proc 	printn

	xor cx,cx
	mov bx,10

next:	xor dx,dx
	div bx
	push dx
	inc cl
	cmp ax,0
	jnz next

nex:	pop dx
	add dl,30h
	mov ah,02
	int 21h
	loop nex


	ret
printn	endp

end