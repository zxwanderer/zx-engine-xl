main:
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
    include "../engine/index.asm"

start_engine:
    MemSetBank muzBank
    ld HL, music_start
    call Music.INIT
    ei
pg:
    halt
    MemSetBank gfxBank
	jp pg
end_main: equ $

  DISPLAY '-----------------------------------'
  DISPLAY "Main size: ", /D, end_main-main
  DISPLAY '-----------------------------------'

	org 0x7D7D

ngBegin:
	di
	push af,bc,de,hl
	exx
	exa
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
	exx
	exa
	pop hl,de,bc,af
	ei
	ret

	align 256
intTab	ds 257
frame_counter:
  dw 0
