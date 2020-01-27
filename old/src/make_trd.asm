DEVICE 	ZXSPECTRUM128

  ORG	#6000
boot.begin_code:
  INCBIN "../code.bin.zx7"
boot.end_code:

  SLOT 3
  PAGE 7
  ORG #C000
boot.begin_screen:
  INCBIN "../screen.bin.zx7"
boot.end_screen:

  SLOT 3
  PAGE 6
  ORG #C000
boot.begin_music:
  INCBIN "../music.bin.zx7"
boot.end_music:

  SLOT 3
  PAGE 1
  ORG #C000
boot.begin_script:
  INCBIN "../script.bin.zx7"
boot.end_script:

// ------  text.bin
    SLOT 3
    PAGE 3
    ORG #C000
text_start:
    include "./script.bin.zx7"
text_end:

  EMPTYTRD "../cell3326.trd" ;create empty TRD image

  include "./basic_boot_trd.asm"

  SAVETRD "../cell3326.trd", "boot.B", boot.Basic, boot.EndBasic - boot.Basic  
  SAVETRD "../cell3326.trd","code.C", boot.begin_code, boot.end_code - boot.begin_code


  ; DISPLAY '-----------------------------------'
  ; DISPLAY 'Basic:  ', /D, boot.EndBasic - boot.Basic
  ; DISPLAY 'Code:   ', /D, boot.end_code - boot.begin_code
  ; DISPLAY 'Screen: ', /D, boot.end_screen - boot.begin_screen
  ; DISPLAY 'Music:  ', /D, boot.end_music - boot.begin_music
  ; DISPLAY 'Script:', /D, boot.end_script - boot.begin_script
  ; DISPLAY '-----------------------------------'


  SLOT 3
  PAGE 7
  ORG #C000
  SAVETRD "../cell3326.trd","screen.C", boot.begin_screen, boot.end_screen - boot.begin_screen

  SLOT 3
  PAGE 6
  ORG #C000
  SAVETRD "../cell3326.trd","music.C", boot.begin_music, boot.end_music - boot.begin_music

  SLOT 3
  PAGE 1
  ORG #C000
  SAVETRD "../cell3326.trd","scripts.C", boot.begin_script, boot.end_script - boot.begin_script
