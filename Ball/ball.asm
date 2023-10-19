; Degenbaev Iskender
; Neptun code: DDF5CS
Code Segment
	assume CS:Code, DS:Data, SS:Stack
	Start:
		mov ax, Code
		mov DS, ax
		
		xor di, di
		mov si, 1 ;1 is downward, -1 is upward
		
		xor dx, dx
		push dx
	Delete:
		mov ax, 03h
		int 10h
		
		mov dx, di
		mov dh, dl
		
		mov dl, 40
		xor bh, bh
		mov ah, 02h
		int 10h
		
		mov dx, offset Ball
		mov ah, 09h
		int 21h
	Delete1:
		sub di, si
		mov dx, di
		mov dh, dl
		
		mov dl, 40
		xor bh, bh
		mov ah, 02h
		int 10h
		
		mov dx, offset Space
		mov ah, 09h
		int 21h
		
		add di, si
		mov dx, di
		mov dh, dl
		
		mov dl, 40
		xor bh, bh
		mov ah, 02h
		int 10h
		
		mov dx, offset Ball
		mov ah, 09h
		int 21h
		
	Delay:
		mov ah, 01h ;00 is waiting for a key without a timer
		int 16h
		jnz End_Program
		
		jz Nokey
		mov ah, 00h
		int 16h
		cmp al, 27
		jz End_Program
	Nokey:
		xor ah, ah
		int 1ah			;load current time to CX:DX
		
		pop cx 			;pop out old time
		push cx			;push in old time
		push dx			;saving current time into the stack
		sub dx, cx		;T(current)-T(old)
		
		cmp di, 5		;separates a screen by 5 parts. first part is slow, las part is fast. accelerate gradually
		jnc Time1		;jump, if di >= 5
		mov al, 16
		jmp Set
	Time1:				;moving of the ball gets faster
		cmp di, 10
		jnc Time2
		mov al, 8
		jmp Set
	Time2:
		cmp di, 15
		jnc Time3
		mov al, 4
		jmp Set
	Time3:
		cmp di, 20
		jnc Time4
		mov al, 2
		jmp Set
	Time4:
		mov al, 1
	Set:
		xor ah, ah
		cmp dx, ax
		pop ax			;needed to update an old time
		jc Delay
		
		pop cx			;pop out an old time from the stack
		push ax 		;push in current time
		
		cmp di, 0 		;if di=0 ball is on the top of the screen, if di!=0 it will go upwards(jump up)
		jz Downward
			
		cmp di, 24
		jz Upward
	Movement:	
		add di, si		; if si=+1 ball goes downward, if si=-1 goes up
		jmp Delete
	Downward:
		mov si, 1
		jmp Movement
	Upward:
		mov si, -1
		jmp Movement
	End_Program:
		pop cx
		mov ax, 4c00h
		int 21h
	Ball: db "O$"
	Space: db " $"
Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends
	End Start
	