; stack.asm

extern printf

section .data
	strng	db	"ABCDE", 0
	strngLen	equ	$ - strng - 1
	fmt1	db	"The original  string: %s", 10, 0
	fmt2	db	"The reversed string: %s", 10, 0
section .bss
section .text
	global main

main:
	push rbp
	mov rbp, rsp

	;print the original string.
	xor rax, rax
	mov rdi, fmt1
	mov rsi, strng
	call printf

	;push character one by one
	xor rax, rax
	mov rbx, strng
	mov rcx, strngLen
	mov r12, 0
	pushLoop:
		mov al, byte [rbx + r12]
		push rax
		inc r12
		loop pushLoop

	;poping character by character.
	mov rbx, strng
	mov rcx, strngLen
	mov r12, 0
	popLoop:
		pop rax
		mov byte [rbx + r12], al
		inc r12
		loop popLoop
	mov byte [rbx + r12], 0

	;printing the reversed string
	mov rax, 0
	mov rdi, fmt2
	mov rsi, strng
	call printf

	mov rsp, rbp
	pop rbp
	ret
