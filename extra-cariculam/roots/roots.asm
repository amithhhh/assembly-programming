;roots.asm

section .data
	prompt_a	db	"Enter the coefficient: ", 0
	promptALen	equ	$ - prompt_a - 1
	one_root_prompt		db		"Since D is zero, only one root exists", 10, 0
	orp_Len				equ		$ - one_root_prompt - 1

section .bss
	buffer_a	resb	16
	a		resq	1
	c		resq	1
	b		resq	1

section .text
	global _start

_start:
	;getting coefficient a
	call get_input
	mov [a], rax

	;getting coefficient b
	call get_input
	mov [b], rax

	;getting coefficient c
	call get_input
	mov [c], rax

	xor rax, rax

	mov rax, [b]
	imul rax, rax
	mov r8, rax

	mov rax, c
	imul rax, a
	shl rax, 2 ;shift operator (bitwise)

	sub r8, rax ;r8 contains d

	cmp r8, 0
	
	je one_root
	jg two_root
	jl img_root

	one_root:
		mov rax, 1
		mov rdi, 1
		mov rsi, one_root_prompt
		mov rdx, orp_Len
		syscall
		done
	
	two_root:
		done

	img_root:
		done



	done:
		mov rax, 60
		mov rdi, 0
		syscall


get_input:
	push rbp
	mov rbp, rsp

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

	xor rax, rax
	xor rcx, rcx
	xor rbx, rbx
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
		mov rsp, rbp
   		 pop rbp
    	 ret
