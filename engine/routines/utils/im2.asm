ngBegin:
	di
	ld (sp_saved_im+1), sp
	ld sp, stack_im
	push af,bc,de,hl
	exx
	ex af, af'
	push af,bc,de,hl,ix,iy

	ld a,(Memory.curBank)
	push af

	LD HL, (frame_counter)
  	INC HL
  	LD (frame_counter), HL

	CALL im2_routines

	pop	af
	call Memory.setBank

	pop iy,ix,hl,de,bc,af
	ex af, af'
	exx
	pop hl,de,bc,af
sp_saved_im:
	LD SP, #0000
	ei
	ret

frame_counter: dw 0

	align 256
intTab:	ds 257

stack_im_begin:
  DEFS 50, 0
stack_im: equ $

stack_engine_begin:
  DEFS 50, 0
stack_engine: equ $

  DISPLAY "Im2 addr begin: ", INIT_VEC, " end: ", $, " Free: ", /D, 0x8000 - $
  DISPLAY '-----------------------------------'
