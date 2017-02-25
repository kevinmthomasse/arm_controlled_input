@ ----------------------------------------------------------------------- @
@ Program:				ARM Controlled Input
@ Version:				1.0
@ Developer:			David West
@						Based on the code dev by Kevin M. Thomas located at
@						https://github.com/kevinmthomasse/x86_Controlled_Input 
@						GitHub repo. 
@ Creation Date:		09/12/16
@ Update Date:			02/16/17
@ Copyright:			CC BY
@ Platform:				ARM BCM2837
@ Compile:				as arm_controlled_input.s -o arm_controlled_input.o
@ Link:					ld arm_controlled_input.o -o arm_controlled_input
@ Description:			Program that takes a maximum of 4 bytes of
@ 						input from the terminal and checks for a
@ 						successful combination of 4 continous integers
@ 						otherwise loops to obtain a fresh buffer of
@ 						input and if 4 continous integers are obtained
@ 						and there are additional characters inputted
@ 						they get flushed from the buffer.
@ ----------------------------------------------------------------------- @


.bss
	buffer:									@ fill 4 bytes with zeros
		.zero 4
		.align

.data
	prompt:
		.asciz "Enter ONLY 4 Integers:  \n"
		.equ len.prompt, .-prompt
	
	result:
		.asciz " is your result!\n"
		.equ len.result, .-result
		.align
 
.text
	.global _start

_start:

	nop

	bl write_prompt

.read_buffer:								@ loop when input values are not
	bl read_buffer							@ between ASCII 0 and 9
	ldr r9, =buffer
	eor r10, r10

	1:
		ldrb r11, [r9, r10]
		cmp r11, #0x30
		blt .read_buffer
		cmp r11, #0x39
		bgt .read_buffer

	add r10, #1
	cmp r10, #3
	ble 1b

	bl write_int_result
	bl flush
	bl write_result

exit:
	eor r0, r0
	mov r7, #1
	svc 0

write_prompt:
	push {r1 - r7, lr}
	mov r7, #4
	mov r0, #1
	ldr r1, =prompt
	mov r2, #len.prompt
	svc #0
	pop {r1 - r7, pc}

read_buffer:
	push {r1 - r9, lr}
	mov r7, #3
	mov r0, #0
	ldr r1, =buffer
	mov r2, #4
	svc #0
	pop {r1 - r9, pc}

write_result:
	push {r1 - r7, lr}
	mov r7, #4
	mov r0, #1
	ldr r1, =result
	mov r2, #len.result
	svc #0
	pop {r1 - r7, pc}

write_int_result:
	push {r1 - r7, lr}
	mov r7, #4
	mov r0, #1
	ldr r1, =buffer
	mov r2, #4
	svc #0
	pop {r1 -r7, pc}

flush:
	push {r1 - r7, lr}
	mov r7, #3
	mov r0, #2
	ldr r1, =buffer
	mov r2, #(1 << 30)						@ 1,073,741,824 bytes 
	svc #0
	pop {r1 - r7, pc}