.filedef temp = R16

.macro jmp_cmd_ne
ERROR skal kaldes med argumenter
.endm

.macro jmp_cmd_ne_i_i_i
	push temp
	lds temp, bt_rc_buf_start
	cpi temp, @0
	brne PC + 7
	lds temp, bt_rc_buf_start + 1
	cpi temp, @1
	brne PC + 3
	;equal
	pop temp
	rjmp PC + 4
	;not equal
	pop temp
	jmp @2
.endm
