; 0xffff +--------+--------+--------+--------+--------+--------+--------+--------+
;        | Bank 0 | Bank 1 | Bank 2 | Bank 3 | Bank 4 | Bank 5 | Bank 6 | Bank 7 |
;        |        |        |(also at|        |        |(also at|        |        |
;        |        |        | 0x8000)|        |        | 0x4000)|        |        |
;        |        |        |        |        |        | screen |        | screen |
; 0xc000 +--------+--------+--------+--------+--------+--------+--------+--------+
;        | Bank 2 |        Any one of these pages may be switched in.
;        |        |
;        | Graph  |
;        |        |
; 0x8000 +--------+
;        | Bank 5 |
;        |        |
;        |        |
;        | screen |
; 0x4000 +--------+--------+
;        | ROM 0  | ROM 1  | Either ROM may be switched in.
;        |        |        |
;        |        |        |
;        |        |        |
; 0x0000 +--------+--------+


; Доступные страницы можно использовать, используя порт $7FFD, зная параметры:

; [r][b] [t][sss]
; sss - бит 0-2 номер страницы, которая будет подключена по адресу $C000
; t - бит 3 отображается экран из страницы 5 или "теневая" из страницы 7.
; b - бит 4 выбор ROM 48 Basic или 128
; r - бит 5 запрет переключения страниц

    MODULE Memory

; меняет BC
setBank:
	ld (curBank),a
cur_scr: 
	; or %00000000
	or 0x10
	ld bc,0x7ffd
	out (c),a
	ret

flipScreen:
	LD A, (cur_scr+1)
	XOR %00001000
	LD (cur_scr+1), A
	RET

curBank:    db 0

    ENDMODULE
