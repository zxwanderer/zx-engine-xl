DEVICE 	ZXSPECTRUM128

// ------   code.bin
    ORG	#6000
prog_start:
    include "_main.asm"
prog_end:

// ------  screen.bin
    ORG #4000
screen_start:
    incbin "../data/laser_screen.scr"
screen_end:

// ------  music.bin
    SLOT 3
    PAGE 7
    ORG #C000
music_start:
    include "_music.asm"
music_end:

// ------  scripts.bin
    SLOT 3
    PAGE 1
    ORG #C000
script_start:
    include "../data/scripts.asm"
script_end:

  DISPLAY '-----------------------------------'
  DISPLAY 'Code:   ', /D, prog_end-prog_start
  DISPLAY 'Screen: ', /D, screen_end-screen_start
  DISPLAY 'Music:  ', /D, music_end-music_start
  DISPLAY 'Script: ', /D, script_end-script_start
  DISPLAY '-----------------------------------'
