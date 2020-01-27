DEVICE 	ZXSPECTRUM128

// ------   code.bin
    ORG	#6000
prog_start:
    include "_main.asm"
prog_end:

im2_start:
    include "_im2.asm"
im2_end:

// ------  music.bin
    SLOT 3
    PAGE 7
    ORG #C000
music_start:
    include "./pages/_music.asm"
music_end:
