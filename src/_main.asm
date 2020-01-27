main:
	JP start_engine

; к сожалению макросы не прописываются глобально при компиляции,
; поэтому приходится делать include до их вызова в коде
; (?) может делать два файла - файл макросов (header) и файл их использования?

    include "../engine/defines.asm"
	include "./defines.asm"
    include "../engine/routines/memory_h.asm"
	include "../engine/routines/im2_h.asm"

start_engine:
	di
	ld sp, stack_engine
	xor a
	out (#fe), a

	SetIM2 INIT_VEC

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

  DISPLAY 'Engine size: ', /D, end_main-main, /D, ' free: ', /D, INIT_VEC-end_main
  DISPLAY '-----------------------------------'
