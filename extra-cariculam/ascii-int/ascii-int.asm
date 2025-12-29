;ascii to integer conversion.
;value = value * 10 + (char - '0')

extern printf

section .data
	prompt		db		"Enter the value: ", 0
	length		equ		$ - prompt
	fmt		db		"%ld x %ld = %ld", 10, 0
section .bss
	buffer 		resb		20
section .text
	global main

main:
	;print the statement
	mov rax, 1
	mov rdi, 1
	mov rsi, prompt
	mov rdx, length
	syscall

	;read input from the user.
	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, 20
	syscall

	;converting ascii to value
	xor rbx, rbx	;result = 0
	xor rcx, rcx	;index = 0

	convert:
		mov al, [buffer + rcx]
		cmp al, 10
		je done

		sub al, '0'
		imul rbx, rbx, 10
		add rbx, rax
		
		inc rcx
		jmp convert
	done:
		mov rcx, 1 ;i = 1
		mulLoop:
			mov rax, rbx
			imul rax, rcx
			push rcx
			
			mov rdi, fmt
			mov rsi, rbx
			mov rdx, rcx
			mov rcx, rax
			call printf
		
			pop rcx

			inc rcx
			cmp rcx, 11
			jne mulLoop
		
	mov rax, 60
	mov rdi, 0
	syscall
	
