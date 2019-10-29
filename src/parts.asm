DEVICE 	ZXSPECTRUM128
    ORG	#6000

prog_start:
    JP start_engine

engine:
    include "../engine/index.asm"

player:
    include "../engine/routines/PTSPLAY.asm"

start_engine:
    MemSetBank 6
    ld HL, music_start
    call INIT
loop:
    ei
pg:
    halt
	call PLAY
	jp pg
prog_end:
    SAVEBIN "code.bin",prog_start, prog_end-prog_start

    ORG #4000
screen_start:
    incbin "../data/laser_screen.scr"
screen_end:
    SAVEBIN "screen.bin",screen_start, screen_end-screen_start

    SLOT 3
    PAGE 6
    ORG #C000
music_start:
    incbin "../data/music/keyjee.pt3"
music_end:

    SAVEBIN "music.bin",music_start, music_end-music_start
