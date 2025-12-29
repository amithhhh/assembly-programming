;asking value from user.

section .data
	prompt		db		"Enter the value: ", 10
	length		equ		$ - prompt
section .bss
	buf		resb		20
section .text
	global _start

_start:
	;print prompt
	mov rax, 1
	mov rdi, 1
	mov rsi,prompt
	mov rdx, length
	syscall

	;read input
	mov rax, 0
	mov rdi, 0
	mov rsi, buf
	mov rdx, 20
	syscall

	;print the value
	mov rdx, rax ;rax now contains no of buffer read.
	mov rax, 1
	mov rdi, 1
	mov rsi, buf
	syscall

	;exit
	mov rax, 60
	xor rdi, rdi
	syscall
