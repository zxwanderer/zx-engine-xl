DEVICE 	ZXSPECTRUM128

  ORG	#6000
boot.begin_code:
  INCBIN "../code.bin.zx7"
boot.end_code:

  SLOT 3
  PAGE 6
  ORG #C000
boot.begin_music:
  INCBIN "../music.bin.zx7"
boot.end_music:

  SLOT 3
  PAGE 7
  ORG #C000
boot.begin_screen:
  INCBIN "../screen.bin.zx7"
boot.end_screen:

  EMPTYTRD "cell3326.trd" ;create empty TRD image

; LOAD_ADDR equ begin_starter
; boot.begin equ LOAD_ADDR
; boot.end equ end_starter
; boot.START_ADDR equ begin_starter

; boot.pageCodeBegin equ begin_code
; boot.pageCodeEnd equ end_code

; boot.pageScreenBegin equ begin_screen
; boot.pageScreenEnd equ end_screen

; boot.page6b equ begin_music
; boot.page6e equ end_music

  include "../engine/routines/basic_boot_trd.asm"

  SAVETRD "cell3326.trd", "boot.B", boot.Basic, boot.EndBasic - boot.Basic
  ; SAVETRD "cell3326.trd","code.C",boot.begin,boot.end-boot.begin
  
  SAVETRD "cell3326.trd","code.C", boot.begin_code, boot.end_code - boot.begin_code


  DISPLAY '-----------------------------------'
  DISPLAY 'SIZE:', /D, boot.end_code - boot.begin_code
  DISPLAY 'SIZE:', /D, boot.end_screen - boot.begin_screen
  DISPLAY 'SIZE:', /D, boot.end_music - boot.begin_music
  DISPLAY '-----------------------------------'

  SLOT 3
  PAGE 7
  ORG #C000
  SAVETRD "cell3326.trd","screen.C", boot.begin_screen, boot.end_screen - boot.begin_screen

  SLOT 3
  PAGE 6
  ORG #C000
  SAVETRD "cell3326.trd","music.C", boot.begin_music, boot.end_music - boot.begin_music
