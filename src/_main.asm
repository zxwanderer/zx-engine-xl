main:
	JP start_engine

INIT_VEC equ 0x7D7D

; к сожалению макросы не прописываются глобально при компиляции,
; поэтому приходится делать два файла - файл макросов (header) и файл их использования

    include "../engine/defines.asm"
    include "../engine/scankeys.asm"
    include "../engine/routines/utils/memory_h.asm"
	include "../engine/routines/utils/im2_h.asm"
	include "../engine/routines/text_h.asm"
    include "../engine/core/engine_h.asm"

    include "./logic/defines/Point.asm"
    include "./logic/defines/Hero.asm"

start_engine:
	di
	ld sp, stack_engine
	xor a
	out (#fe), a

	SetIM2 INIT_VEC

    MemSetBank muzBank
    call Music.INIT
    ei

	JP zxengine.start

im2_routines:
    ; MemSetGraphBank
    ; DUP 39
    ; CALL draw_sprite
    ; EDUP

	MemSetMuzBank
    CALL Music.PLAY

	RET

    include "../engine/routines/utils/memory.asm"
    include "../engine/routines/utils/math.asm"
    include "../engine/routines/utils/input.asm"
    include "../engine/routines/utils/screen.asm"
    include "../engine/routines/text.asm"
    include "../engine/routines/tiles16.asm"
    include "../engine/routines/view.asm"
    include "../engine/routines/map.asm"    
    include "../engine/core/engine.asm"

    include "./logic/heroes.asm"
    include "./logic/entities.asm"

; Кастомные вызовы из скриптов через CallCode 
; Если вызываемая подпрограмма использует переключение страничек, ее нельзя
; держать в той же страничке :) Поэтому их приходится размещать тут, в верхней памяти.
    include "../scripts/scripts_binaries.asm"

end_main: equ $

  DISPLAY 'Engine size: ', /D, end_main-main, /D, ' free: ', /D, INIT_VEC-end_main
  DISPLAY '-----------------------------------'
