DEVICE 	ZXSPECTRUM128

// ------   code.bin
    ORG	#6000
prog_start:
    include "_main.asm"
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
    PAGE 7
    ORG #C000
music_start:
    include "_music.asm"
music_end:

    SAVEBIN "music.bin",music_start, music_end-music_start
