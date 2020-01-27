main:

start_engine:
	di
	ld sp, stack_engine
	xor a
	out (#fe), a

	ld hl,intTab
	ld de,intTab+1
	ld bc,0x100
	ld a,h
	ld i,a
	ld (hl),high ngBegin
	ldir
	im 2

inf_loop:
    JP inf_loop
    ; MemSetBank muzBank
    ; call Music.INIT
    ; ei
	; jp zxengine.start


; stack_im_begin:
;   DEFS 100, 0
; stack_im: equ $

end_main: equ $

  DISPLAY '-----------------------------------'
  DISPLAY 'Engine size: ', /D, end_main-main, /D, ' free: ', /D, 0x7D7D-end_main
  DISPLAY '-----------------------------------'


stack_engine_begin:
  DEFS 100, 0
stack_engine: equ $

  DISPLAY $
