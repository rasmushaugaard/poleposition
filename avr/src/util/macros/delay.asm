.filedef counter1 = R16
.filedef counter2 = R17
.filedef counter3 = R18
.filedef c1 = R19
.filedef c2 = R20
.filedef usercounter = R21
.filedef temp = R22

rjmp delay_macro_end

fulldec1:	; 5 + 4 c1 inkl. kald & return
	dec counter1
	nop
	brne fulldec1
	ret

fulldec2:	; 5 + (9 + 4 c1) c2 inkl. kald & return
	mov counter1, c1
	rcall fulldec1
	dec counter2
	brne fulldec2
	ret

fulldec3:	;5 + (7 + (9 + 4 c1) c2) c3 inkl. kald & return
	mov counter2, c2
	rcall fulldec2
	dec counter3
	brne fulldec3
	ret

delayms:	; solved for values
	push c1
	push c2
	push counter1
	push counter2
	push counter3

	ldi c1, 15
	ldi c2, 228
	ldi counter3, 1
	rcall fulldec3

	pop counter3
	pop counter2
	pop counter1
	pop c2
	pop c1
	ret

delays:		;solved for values
	push c1
	push c2
	push counter1
	push counter2
	push counter3


	ldi c1, 183
	ldi c2, 88
	ldi counter3, 245
	rcall fulldec3

	pop counter3
	pop counter2
	pop counter1
	pop c2
	pop c1
	ret

.macro delayms
.endm

.macro delayms_i
	push temp
	in temp, SREG
	push usercounter
	ldi usercounter, @0
	cpi usercounter, 0
	breq PC + 5
;loop
	call delayms
	dec usercounter
	brne PC - 3
	pop usercounter
	out SREG, temp
	pop temp
.endm

.macro delayms_8
	push temp
	in temp, SREG
	cpi @0, 0
	breq PC + 5
;loop
	call delayms
	dec usercounter
	brne PC - 3
	out SREG, temp
	pop temp
.endm

.macro delays
.endm

.macro delays_i
	push temp
	in temp, SREG
	push usercounter
	ldi usercounter, @0
	cpi usercounter, 0
	breq PC + 5
;loop:
	call delays
	dec usercounter
	brne PC - 3
	pop usercounter
	out SREG, temp
	pop temp
.endm

.macro delays_8
	push temp
	in temp, SREG
	cpi @0, 0
	breq PC + 5
;loop
	call delays
	dec usercounter
	brne PC - 3
	out SREG, temp
	pop temp
.endm

delay_macro_end:
