; hello4.asm
extern printf	; declare the function as external 

section .data
	msg	db	"Hello, World!", 0
	fmtstr	db	"This is our string: %s", 0, 10 ;print format

section .bss
section .text
	global main
main:
	push rbp
	mov rbp, rsp
	
	mov rdi, fmtstr	;first arguement for printf
	mov rsi, msg	;second arg
	mov rax, 0
	
	call printf

	mov rsp, rbp
	pop rbp

	mov rax, 60
	mov rdi, 0

	syscall
