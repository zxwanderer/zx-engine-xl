DEVICE 	ZXSPECTRUM128

// ------   code.bin
    ORG	#6000
prog_start:
    include "_main.asm"
prog_end:

	org INIT_VEC
im2_start:
    include "../engine/routines/im2.asm"
im2_end:

// ------  music.bin
    SLOT 3
    PAGE 7
    ORG #C000
music_start:
    include "./pages/_music.asm"
music_end:

  DISPLAY 'Music:  ', /D, music_end-music_start, ' free: ', /D, 0x10000 - music_end
;   DISPLAY 'Script: ', /D, script_end-script_start, ' free: ', /D, 0x10000 - script_end
;   DISPLAY 'Text:   ', /D, text_end-text_start, ' free: ', /D, 0x10000 - text_end
;   DISPLAY 'Map:    ', /D, map_end-map_start, ' free: ', /D, 0x10000 - map_end
;   DISPLAY 'Graph:  ', /D, graph_end-graph_start, ' free: ', /D, 0x10000 - graph_end
  DISPLAY '-----------------------------------'
