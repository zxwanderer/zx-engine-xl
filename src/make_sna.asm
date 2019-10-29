DEVICE 	ZXSPECTRUM128
  ORG #6000

prog_start:
  LD HL, begin_screen
  LD DE, #4000
  call unzip
  di
  halt

begin_code:
  INCBIN "../code.bin"

unzip:
  include "../external_src/zx7/zx7.a80"

end_code:

  ; ORG #8000
begin_screen:
  INCBIN "../screen.bin.zx7"
end_screen:

;   SLOT 3
;   PAGE 6
;   ORG #C000
; begin_music:
;   INCBIN "../music.bin"
; end_music:

  SAVESNA "../boot.sna",prog_start
