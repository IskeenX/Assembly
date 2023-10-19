; Degenbaev Iskender
; Neptun code: DDF5CS
Code Segment
	assume CS:Code, DS:Data, SS:Stack	
	Start:
		mov ax, Code
		mov DS, ax
		mov di, offset value
		mov ax, 03
		int 10h
	Input:
		xor ax, ax
		int 16h
		
		mov bx, ax
		mov ax, 03
		int 10h
		mov ax, bx
		
		cmp al, 27
		jz End_Program
		
		mov cx, 10
		mov ah, '0'
	Exam:
		cmp al, ah
		jz Store
		inc ah
		loop Exam
		
		mov ah, 02h
		mov bh, 0
		mov dh, 10
		mov dl, 0
		int 10h
		
		mov dx, offset fault
		mov ah, 09
		int 21h
		
		jmp Input
	Store:
		mov [di], al
		inc di
		mov al, '$'
		mov [di], al
		
		mov ah, 02h
		mov bh, 0
		mov dh, 5
		mov dl, 28
		int 10h
		
		mov dx, offset value
		mov ah, 09h
		int 21h
		
		mov ax, offset value
		add ax, 4
		cmp ax, di
		jnz Input
	
		mov ah, 02h
		mov bh, 0
		mov dh, 7
		mov dl, 0
		int 10h
		
		mov dx, offset message
		mov ah, 09h
		int 21h
	End_Program:
		mov ax, 4c00h
		int 21h
	value:	db '****$'
	fault:	db 'Illegal character!$'
	message: db 'End of Input$'
Code Ends
	
Data Segment
Data Ends

Stack Segment
Stack Ends

End Start
	