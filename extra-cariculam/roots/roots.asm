;roots.asm

section .data
	prompt_a	db	"Enter a: ", 0
	promptALen	equ	$ - prompt_a - 1

section .bss
	buffer_a	resb	16
	a		resq	1

section .text
	global _start

_start:
	;prompting

	mov rax, 1
	mov rdi, 1
	mov rsi, prompt_a
	mov rdx, promptALen
	syscall
	
	;getting value from user
	mov rax, 0
	mov rdi, 0
	mov rsi, buffer_a
	mov rdx, 16
	syscall

	;converting string into integer

	xor rax, rax
	xor rcx, rcx

	convert_loop:
		mov bl, [buffer_a + rcx]
		cmp bl, 10
		je convert_done

		sub bl, '0'
		imul rax, rax, 10
		add rax, rbx

		inc rcx
		jmp convert_loop

	convert_done:
		mov [a], rax

	mov rax, 60
	mov rdi, 0
	syscall
