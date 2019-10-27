DEVICE 	ZXSPECTRUM128	;это внутренняя директива SJASMPLUS, которая подсказывает ему, под какой клон организовать память
		ORG	#8000	;старт программы ровно по центру памяти 48К
BEGIN:
    LD HL, music
    call INIT
loop:
    ei
pg:
    halt
	call PLAY
	jP pg

player:
    include "../engine/routines/PTSPLAY.asm"
music:
    incbin "../data/music/keyjee.pt3"

	SAVESNA "../cell3326.sna",BEGIN	;в папку unreal после компиляции сохранится снапшот для запуска в эмуляторе, содержащий программу, описанную сверху
