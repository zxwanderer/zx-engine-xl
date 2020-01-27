main:
	JP start_engine

; к сожалению макросы не прописываются глобально при компиляции,
; поэтому приходится делать include до их вызова в коде
; (?) может делать два файла - файл макросов (header) и файл их использования?

    include "../engine/defines.asm"
    include "../engine/routines/memory_h.asm"

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

    MemSetBank muzBank
    call Music.INIT
    ei

inf_loop:
	LD A,R
	AND %00000111
	OUT(#FE),A
    JP inf_loop
	; jp zxengine.start

im2_routines:
	MemSetBank muzBank
    CALL Music.PLAY
	RET

    include "../engine/routines/memory.asm"

end_main: equ $

  DISPLAY '-----------------------------------'
  DISPLAY 'Engine size: ', /D, end_main-main, /D, ' free: ', /D, 0x7D7D-end_main
  DISPLAY '-----------------------------------'

  DISPLAY $
