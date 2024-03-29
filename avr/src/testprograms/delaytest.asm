.include "src/def/m32def.inc"
.org 0x00
	rjmp init

.org 0x2a
.include "src/macros/delay.asm"
init:
	.include "src/bootloader/stack_pointer.asm"
	ldi R16, (1<<4)
	out DDRD, R16
main:
	delays [1]
	cbi PORTD, 4
	delays [1]
	sbi PORTD, 4
	rjmp main
