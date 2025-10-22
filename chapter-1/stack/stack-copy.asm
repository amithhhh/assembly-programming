; stack-copy.asm

extern printf

section .data
	string		db		"MALAYALAM", 0
	stringLen       equ             $ - string - 1
	strCopy		times stringLen+1	db	0
	fmt1		db		"The original string: %s", 10, 0
	fmt2		db		"The reversed string: %s", 10, 0
	fmtYes		db		"It is palindrome", 10, 0
	fmtNo		db		"It is not a palindrome", 10, 0

section .bss

section .text
	global main

main:
	push rbp
	mov rbp, rsp

		mov rdi, fmt1
		mov rsi, string
		mov rax, 0
		call printf

		xor rax, rax
		mov rbx, string
		mov rcx, stringLen
		mov r12, 0

		pushLoop:
			mov al, byte [rbx+r12]
			push rax
			inc r12

		loop pushLoop

		mov rbx, strCopy
		mov rcx, stringLen
		mov r12, 0

		popLoop:
			pop rax
			mov byte [rbx+r12], al
			inc r12
		loop popLoop

		mov byte [rbx+r12], 0

		mov rdi, fmt2
		mov rsi, strCopy
		mov rax, 0
		call printf

		;comparetwo strings

		mov rsi, string
		mov rdx, strCopy
		mov rcx, stringLen
		mov r12, 0 	;loop controlling variable
		mov r13, 1	;flag 1 means it is a palindrome

		compareLoop:
			mov al, [rsi + rcx - 1]
			mov bl, [rdx + rcx - 1]
			cmp al, bl
			jne notPalindrome
			;inc r12
			loop compareLoop
			jmp printResult

		notPalindrome:
			mov r13, 0

		printResult:
			cmp r13, 1
			jne printNo
			mov rdi, fmtYes
			jmp printMsg
		
		printNo:
			mov rdi, fmtNo

		printMsg:
			mov rax, 0
			call printf

	mov rsp, rbp
	pop rbp
	ret	
