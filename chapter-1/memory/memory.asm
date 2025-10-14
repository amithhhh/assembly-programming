; memory.asm

section .data
	bNum	db	123
	wNum	dw	12345
	warray	times	5 dw 0		;array of 5 words
	dNum	dd	12345
	qNum1	dq	12345
	text1	db	"abc", 10, 0
	qNum2	dq	3.141592654
	text2	db	"cde", 0

section .bss
	bvar	resb	1
	dvar	resd	1
	wvar	resw	10
	qvar	resq	3

section .text
	global main

main:
	push rbp
	mov rbp,rsp

	lea rax, [bNum]		;Move address of bNum in rax
	mov rax, bNum		;load address of bNum in rax

	mov rax, [bNum]		;move value at bNum in rax
	mov [bvar], rax		; load from rax at address bvar

	lea rax, [bvar]		;load address of bvar in rax
	lea rax, [wNum]		;load address of wNum in rax

	mov rax, [wNum]		;mov content of wNum in rax

	lea rax, [text1]	;load of address of text1 in rax

	mov rax, text1		;load address of text1 in rax

	mov rax, text1+1	;load second character in rax
	lea rax, [text1+1]
	mov rax, [text1]
	mov rax, [text1+1]

	mov rax, 1
	mov rdi, 1
	mov rsi, text1+1
	mov rdx, 2

	syscall

	mov rsp, rbp
	pop rbp
	ret
