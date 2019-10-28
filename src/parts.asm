DEVICE 	ZXSPECTRUM128
    ORG	#6000
BEGIN:
    JP start_engine

engine:
    include "../engine/index.asm"

player:
    include "../engine/routines/PTSPLAY.asm"

start_engine:
    MemSetBank 7
    LD HL, music
    call INIT
loop:
    ei
pg:
    halt
	call PLAY
	jP pg

    ORG #4000
screen:
    incbin "../data/laser_screen.scr"

    SLOT 3

    PAGE 7
    ORG #C000
music:
    incbin "../data/music/keyjee.pt3"

    PAGE 6
    ORG #C000
    incbin "../data/laser_screen.scr"

    SAVESNA "../cell3326.sna",BEGIN
