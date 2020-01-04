DEVICE 	ZXSPECTRUM128

    ORG	#6000
// ------   code.bin

memBufer equ #8000
// при запуске имеем:
// muzBank (#17)- сжатая музыка
// scrBank0 (#11) - сжатая картинка
    JP prog_start

engine:
    include "../engine/index.asm"

player:
    include "../engine/routines/PTSPLAY.asm"

prog_start:

start_engine:
    MemSetBank muzBank
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

// ------  screen.bin

    ORG #4000
screen_start:
    incbin "../data/laser_screen.scr"
screen_end:
    SAVEBIN "screen.bin",screen_start, screen_end-screen_start

// ------  music.bin
    SLOT 3
    PAGE 6
    ORG #C000
music_start:
    incbin "../data/music/keyjee.pt3"
music_end:

    SAVEBIN "music.bin",music_start, music_end-music_start
