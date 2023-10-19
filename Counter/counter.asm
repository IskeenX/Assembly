; Degenbaev Iskender
; Neptun code: DDF5CS
Code	Segment
	assume CS:Code, DS:Data, SS:Stack
	Start:
		mov ax, Code
		mov DS, ax

		mov ax, 3
		int 10h
	Display:
		mov ah, 02h
		mov bh, 0
		mov dh, 10
		mov dl, 0
		int 10h

		mov dx, offset message1
		mov ah, 09h
		int 21h

		mov dx, offset counter2
		mov ah, 09h
		int 21h
		
		mov dx, offset counter
		mov ah, 09h
		int 21h
		
	Input:
		xor ax, ax
		int 16h

		cmp al, 27
		jz End_ProgramMessage

		cmp al, "a"
		jz Count
		
		cmp al, "d"
		jz Decount
		
		jmp Display2
	Display2:
		mov ah, 02h
		mov bh, 0
		mov dh, 10
		mov dl, 0
		int 10h
		
		mov dx, offset message3
		mov ah, 09h
		int 21h
		
		jmp Input
	Count:
		mov di, offset counter
		mov al, [di]
		cmp al, "9"
		jz CountTen
		
		inc al
		mov [di], al
		jmp Input
	CountTen:
		mov di, offset counter
		mov al, "0"
		mov [di], al
		
		mov di, offset counter2
		mov al, [di]
		cmp al, "9"
		jz End_ProgramMessage
		
		inc al
		mov [di], al
		jmp Display
	Decount:
		mov di, offset counter
		mov al, [di]
		cmp al, "0"
		jz DecountTen
		
		dec al
		mov [di], al
		jmp Display
	DecountTen:
		mov di, offset counter
		mov al, "9"
		mov [di], al
		
		mov di, offset counter2
		mov al, [di]
		cmp al, "0"
		jz End_ProgramMessage
		
		dec al
		mov [di], al
		jmp Display
	End_ProgramMessage:
		mov dx, offset message2
		mov ah, 09h
		int 21h
		jmp End_Program
	End_Program:
		mov ax, 4c00h
		int 21h
	message1: db "Counter: $"
	counter: db "0$"
	counter2: db "0$"
	message2: db " The End! Start again!$"
	message3: db "Wrong key      $"
Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends
	End Start
