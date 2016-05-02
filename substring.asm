;program to input two strings and check whether the second is substring of first
.model small
.stack 
.data

msg1	db	"Enter first string : $"
msg2	db	10,13,"Enter second string : $"
res1	db	10,13,"is a substring$"
res2	db	10,13,"is not a substring$"
s1	db	10	dup('$')
s2	db	10	dup('$')

.code
main 	proc
	mov ax, @data
	mov ds, ax
	mov es, ax

	lea dx,msg1
	call printm

	lea dx,s1
	call reads

	lea dx,msg2
	call printm

	lea dx,s2
	call reads

	mov al,s1[1]
	mov bx,2

next:	lea si,s1[bx]
	cmp al,s2[1]
	jl notsub

	lea di,s2[2]
	mov cl,s2[1]
	xor ch,ch
	cld
	repz cmpsb
	jz subs
	dec al
	inc bx
	jmp next

subs:	lea dx,res1
	int 21h	
	jmp exit

notsub:	lea dx,res2
	int 21h	

exit:	mov ax, 4c00h
	int 21h
main 	endp




reads	proc
	
	mov ah,0ah
	int 21h

reads	endp




printm	proc
	mov ah,09
	int 21h
	ret
printm	endp



end