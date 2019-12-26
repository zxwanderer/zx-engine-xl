DEVICE 	ZXSPECTRUM128

  ORG	#6000
begin_starter:
  INCBIN "../code.bin.zx7"
end_starter:

  SLOT 3
  PAGE 6
  ORG #C000
begin_music:
  INCBIN "../music.bin.zx7"
end_music:

  SLOT 3
  PAGE 7
  ORG #C000
begin_screen:
  INCBIN "../screen.bin.zx7"
end_screen:

  EMPTYTRD "cell3326.trd" ;create empty TRD image

LOAD_ADDR equ begin_starter
boot.begin equ LOAD_ADDR
boot.end equ end_starter
boot.START_ADDR equ begin_starter

boot.page0b equ begin_screen
boot.page0e equ end_screen

  include "../engine/routines/basic_boot_trd.asm"

  SAVETRD "cell3326.trd", "boot.B", boot.Basic, boot.EndBasic - boot.Basic
  ; SAVETRD "cell3326.trd","code.C",boot.begin,boot.end-boot.begin

  DISPLAY '-----------------------------------'
  DISPLAY 'SIZE:', boot.EndLine1 - boot.Line1
  DISPLAY '-----------------------------------'

  SAVETRD "cell3326.trd","screen.C",begin_screen,end_screen-begin_screen


  ;   SLOT 3
  ;   PAGE 6
  ;   ORG #C000
  ; SAVETRD "cell3326.trd","music.C",begin_music,end_music-begin_music
