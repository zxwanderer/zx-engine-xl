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

// ------  text.bin
    SLOT 3
    PAGE 3
    ORG #C000
text_start:
    include "_text.asm"
text_end:

  DISPLAY '-----------------------------------'
;   DISPLAY 'Code:   ', /D, prog_end-prog_start, ' free: ', /D, 0x8000 - prog_end
;   DISPLAY 'Screen: ', /D, screen_end-screen_start, ' free: ', /D, 0x10000 - screen_end
  DISPLAY 'Music:  ', /D, music_end-music_start, ' free: ', /D, 0x10000 - music_end
  DISPLAY 'Script: ', /D, script_end-script_start, ' free: ', /D, 0x10000 - script_end
  DISPLAY 'Text:   ', /D, text_end-text_start, ' free: ', /D, 0x10000 - text_end
  DISPLAY '-----------------------------------'
