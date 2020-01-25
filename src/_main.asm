main:
	di
	ld sp, stack_engine
	xor a
	out (#fe), a

	ld hl,intTab
	ld de,intTab+1
	ld bc,0x100
	ld a,h
	ld i,a
	ld (hl),high ngBegin
	ldir
	im 2
    JP start_engine

engine:
    include "../engine/main.asm"

start_engine:
    MemSetBank muzBank
    call Music.INIT
    ei
	jp zxengine.start

stack_im_begin:
  DEFS 100, 0
stack_im: equ $

stack_engine_begin:
  DEFS 100, 0
stack_engine: equ $

end_main: equ $

  DISPLAY '-----------------------------------'
  DISPLAY "Main size: ", /D, end_main-main
  DISPLAY '-----------------------------------'

	org 0x7D7D

; Deja Vu #05
; 31 мая 1998
;   Программирование  
; CODING - Использование стека при разрешенных прерываниях.

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

	MemSetBank muzBank
    call Music.PLAY
	
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

	DISPLAY $