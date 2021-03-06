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

// ------  map.bin
    SLOT 3
    PAGE 4
    ORG #C000
map_start:
    include "_map.asm"
map_end:

// ------  graph.bin
    SLOT 3
    PAGE 0
    ORG #C000
graph_start:
    include "_graph.asm"
graph_end:

  DISPLAY '-----------------------------------'
  DISPLAY 'Music:  ', /D, music_end-music_start, ' free: ', /D, 0x10000 - music_end
  DISPLAY 'Script: ', /D, script_end-script_start, ' free: ', /D, 0x10000 - script_end
  DISPLAY 'Text:   ', /D, text_end-text_start, ' free: ', /D, 0x10000 - text_end
  DISPLAY 'Map:    ', /D, map_end-map_start, ' free: ', /D, 0x10000 - map_end
  DISPLAY 'Graph:  ', /D, graph_end-graph_start, ' free: ', /D, 0x10000 - graph_end
  DISPLAY '-----------------------------------'
