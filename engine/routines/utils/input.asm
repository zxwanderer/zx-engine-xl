MODULE input

; статус нажатых кнопок
pressButtons: defb 00

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
	; в HL указатель на таблицу клавиш вида [KEY_XXX] [BUTTON_XXX]
scanKeys:
	LD IX, pressButtons
scanKeys_loop:
	LD A,(HL) ;//  загружаем первый байт
	AND A  ;проверяем на 0
	RET Z ; возвращаем если 0
	INC HL ; увеличиваем HL
	IN A,(0xFE) ; читаем значение
	AND (HL) ; сравниваем со вторым байтом
	INC HL   ; увеличиваем указатель
	JR NZ,scanKeys
	LD A,(HL)
	OR (IX)
	JR scanKeys_loop

ENDMODULE
