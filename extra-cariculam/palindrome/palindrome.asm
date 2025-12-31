;checking palindrome using assembly.

section .data
	prompt		db	"Enter the prompt: "
	prompt_len	equ	$ - prompt
	success		db	"[+]The entered text is palindrome.", 10, 0
	successLen	equ	$ - success - 1
	notSucess	db	"[-]The entered text is not palindrome.", 10, 0
	notSucessLen	equ	$ - notSucess - 1
section .bss
	buffer		resb		100
section .text
	global _start

_start:
	;printing the prompt
	mov rax, 1
	mov rdi, 1
	mov rsi, prompt
	mov rdx, prompt_len
	syscall

	;reading string from user
	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, 100
	syscall

	;checking the palindrome.
	mov rcx, rax
	dec rcx
	dec rcx
	mov r12, 0
	check:
		mov al, byte [buffer + r12]
		cmp al, byte [buffer + rcx]
		jne printNot
		inc r12
		dec rcx
		cmp r12, rcx
		jl check
	print:
		mov rax, 1
		mov rdi, 1
		mov rsi, success
		mov rdx, successLen
		syscall
		jmp exit
	printNot:
		mov rax, 1
		mov rdi, 1
		mov rsi, notSucess
		mov rdx, notSucessLen
		syscall

	exit:
		;exit from the code.
		mov rax, 60
		mov rdi, 0
		syscall
