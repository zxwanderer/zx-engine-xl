DEVICE 	ZXSPECTRUM128
    ORG	#6000
// ------   code.bin

memBufer=#8000
// при запуске имеем:
// muzBank (#17)- сжатая музыка
// scrBank0 (#11) - сжатая картинка
    JP prog_start

engine:
    include "../engine/index.asm"

player:
    include "../engine/routines/PTSPLAY.asm"

prog_start:

    MemSetBank Memory.muzBank // в #C000 - музыка
    ld hl, #C000
    ld de, memBufer
    call unzip
    ld hl, memBufer
    ld de, #C000
    ld bc, $3FFF   ; количество байт для копирования (размер файла data.bin)
    ldir

    MemSetBank Memory.scrBank0 // в #C000 - картинка
    ld de, memBufer
    call unzip
    ld hl, memBufer
    ld de, #C000
    ld bc, $3FFF   ; количество байт для копирования (размер файла data.bin)
    ldir

    JP start_engine

start_engine:
    MemSetBank Memory.muzBank
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
