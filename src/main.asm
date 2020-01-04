main:
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

player:
    include "../engine/routines/PTSPLAY.asm"

start_engine:
    MemSetBank muzBank
    ld HL, music_start
    call INIT
    ei
pg:
    halt
    MemSetBank gfxBank
	jp pg

	org 0x7D7D

ngBegin:
	di
	push af,bc,de,hl
	exx
	exa
	push af,bc,de,hl,ix,iy

	MemSetBank muzBank
    call PLAY
	
	pop iy,ix,hl,de,bc,af
	exx
	exa
	pop hl,de,bc,af
	ei
	ret

	align 256
intTab	ds 257
