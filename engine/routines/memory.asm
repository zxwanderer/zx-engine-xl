; 0xffff +--------+--------+--------+--------+--------+--------+--------+--------+
;        | Bank 0 | Bank 1 | Bank 2 | Bank 3 | Bank 4 | Bank 5 | Bank 6 | Bank 7 |
;        |        |        |(also at|        |        |(also at|        |        |
;        |        |        | 0x8000)|        |        | 0x4000)|        |        |
;        |        |        |        |        |        | screen |        | screen |
; 0xc000 +--------+--------+--------+--------+--------+--------+--------+--------+
;        | Bank 2 |        Any one of these pages may be switched in.
;        |        |
;        |        |
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

    MODULE memory

    MACRO MemSetBank bank_
        ld a, bank_
        call memory.setBank
    ENDM

; mempages
gfxBank=0
scrBank0=1
scrBank1=3
mapBank0=4
mapBank1=6
muzBank=7

setBank:
    ; push bc
	and 7
	ld (curBank),a
	or 0x10
	ld bc,0x7ffd
	out (c),a
	; pop bc
	ret

curBank:    db 0

    ENDMODULE
