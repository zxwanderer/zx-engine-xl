DEVICE 	ZXSPECTRUM128

;   ORG	#6000
; begin_starter:
;   ; INCBIN "../code.bin"
;   ld a,#17,bc,#7FFD:out (c),a
;   ld hl, #C000
;   ld de, #4000
;   call unzip
;   di
;   halt
; unzip:
;   include "../external_src/zx7/zx7.a80"
; end_starter:

;     SLOT 3
;     PAGE 6
;     ORG #C000
; begin_music:
;   INCBIN "../music.bin"
; end_music:


; LOAD_ADDR equ begin_starter
; boot.begin equ LOAD_ADDR
; boot.end equ end_starter
; boot.START_ADDR equ begin_starter
; boot.page0b equ begin_screen
; boot.page0e equ end_screen

  include "../engine/routines/basic_boot_trd.asm"
  EMPTYTRD "cell3326.trd" ;create empty TRD image
  SAVETRD "cell3326.trd", "boot.B", boot.Basic, boot.EndBasic - boot.Basic
  ; SAVETRD "cell3326.trd","code.C",boot.begin,boot.end-boot.begin

  ; DISPLAY '-----------------------------------'
  ; DISPLAY 'SIZE:', boot.EndLine1 - boot.Line1
  ; DISPLAY '-----------------------------------'

  ; SLOT 3
  ; PAGE 6
  ORG #4000
begin_screen:
  INCBIN "../screen.bin"
end_screen:

boot.page0b equ begin_screen
boot.page0e equ end_screen
  DISPLAY 'boot.page0b: ', boot.page0b
  DISPLAY 'boot.page0e: ', boot.page0e
  SAVETRD "cell3326.trd","screen.C",begin_screen,end_screen-begin_screen

  ;   SLOT 3
  ;   PAGE 6
  ;   ORG #C000
  ; SAVETRD "cell3326.trd","music.C",begin_music,end_music-begin_music
