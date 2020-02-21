MODULE input

waitKey:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr z,waitKey
	ret

noKey:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr nz,noKey
	ret

	; честно стырено из движка Wanderers by SamStyle
scanKeys:
	ld a,(HL) ;//  загружаем первый байт
	and a  ;проверяем на 0
	ret z ; возвращаем если 0
	inc hl ; увеличиваем HL
	in a,(0xfe) ; читаем значение
	and (hl) ; сравниваем со вторым байтом
	inc hl   ; увеличиваем указатель
	ld e,(hl)
	inc hl
	ld d,(hl) ; запоминаем в DE указатель на процедуру
	inc hl    ; увеличиваем HL
	jr nz,scanKeys
	or 2
	ret

ENDMODULE
