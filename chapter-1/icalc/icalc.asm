; icalc.asm

extern printf

section .data
	number1		dq		12345678901234567
	number2		dq		10000
	neg_num		dq		-12
	fmt		db		"The numbers are %ld and %ld", 10, 0
	fmtint		db		"%s %ld", 10, 0
	sumi		db		"The sum is", 0
	difi		db		"The difference is", 0
	inci		db		"Number 1 Incremented: ", 0
	deci		db		"Number 1 Decremented: ", 0
	sali		db		"Number 1 shift left 2 (x4): ", 0
	sari		db		"Number 1 shift right 2 (/4):", 0
	sariex		db		"Number 1 shift right 2 (/4) with sign extension: ", 0
	multi		db		"The product is: ", 0
	divi		db		"The integer quotient is", 0
	remi		db		"The reminder is", 0

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

	; incrementing-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	mov rax, [number1]
	inc rax

	mov [resulti], rax
	;displaying the result

	mov rdi, fmtint
	mov rsi, inci
	mov  rdx, [resulti]
	xor rax, rax

	call printf

	; decrementing---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	mov rax, [number1]
	dec rax
	mov [resulti], rax	

	mov rdi, fmtint
	mov rsi, deci
	mov rdx, [resulti]
	mov rax, 0
	
	call printf	

	; shift arithmatic left------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	mov rax, [number1]
	sal rax, 2

	mov [resulti], rax
	mov rdi, fmtint
	mov rsi, sali
	mov rdx, [resulti]
	mov rax, 0
	mov rax, 0
	
	call printf

	;shift arithmatic right--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;

	mov rax, [number1]
	sar rax, 2

	mov [resulti], rax
	mov rdi, fmtint
	mov rsi, sari
	mov rdx, [resulti]
	mov rax, 0
	
	call printf

	; shift arithmetic right with sign extension----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	mov rax, [neg_num]
	sar rax, 2

	mov [resulti], rax
	mov rdi, fmtint
	mov rsi, sariex
	mov rdx, [resulti]
	mov rax, 0
	
	call printf

	; multiply---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	mov rax, [number1]
	imul qword [number2]

	mov [resulti], rax
	mov rdi, fmtint
	mov rsi, multi
	mov rdx, [resulti]
	mov rax, 0

	call printf

	; dividing-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	mov rax, [number1]
	mov rdx, 0 ; rdx needs to be zero before idiv

	idiv qword [number2]

	mov [resulti], rax
	mov [modulo], rdx

	mov rdi, fmtint
	mov rsi, divi
	mov rdx, [resulti]
	xor rax, rax

	call printf

	mov rdi, fmtint
	mov rsi, remi
	mov rdx, [modulo]
	xor rax, rax

	call printf

	mov rsp, rbp
	pop rbp
	ret
