; icalc.asm

extern printf

section .data
	number1		dq		128
	number2		dq		19
	neg_num		dq		-12
	fmt		db		"The numbers are %ld and %ld", 10, 0
	fmtint		db		"%s %ld", 10, 0
	sumi		db		"The sum is", 0
	difi		db		"The difference is", 0

section .bss
	resulti		resq		1
	modulo		resq		1

section .text
	global main

main:
	push rbp
	mov rbp, rsp

	mov rdi, fmt
	mov rsi, [number1]
	mov rdx, [number2]
	mov rax, 0
	
	call printf

	;adding--------------------------------------------------------------------------------------------------------------------------------

	mov rax, [number1]
	add rax, [number2]
	mov [resulti], rax

	mov rdi, fmtint
	mov rsi, sumi
	mov rdx, [resulti]
	xor rax, rax

	call printf

	;subtracting-----------------------------------------------------------------------------------------------------------------------------

	mov rax, [number1]
	sub rax, [number2]
	mov [resulti], rax

	mov rdi, fmtint
	mov rsi, difi
	mov rdx, [resulti]
	xor rax, rax
	
	call printf

	mov rsp, rbp
	pop rbp
	ret
