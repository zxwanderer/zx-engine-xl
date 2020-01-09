MODULE zxengine

  MACRO GoTo addr
    defw zxengine.goto_me
    defw addr
  ENDM

  MACRO CallCode ptr
    defw zxengine.call_code_me
    defw ptr
  ENDM

  MACRO CallScript ptr
    defw zxengine.call_script_me
    defw ptr
  ENDM

; сканировать таблицу в зависимости от нажатой клавиши
  MACRO ScanKeyTable ptr
    defw zxengine.scan_keys_me
    defw ptr
  ENDM

call_code_me:
  mLDE
  PUSH HL
  EX HL,DE
  CALL callHL
  POP HL
  JP process

callHL:  JP (hl)

goto_me:
  mLDE
  EX HL, DE
  JP process

scan_keys_me: ; ================ scan keys
	mLDE
	PUSH HL
	EX DE, HL
	call scanKeys; возвратились из scankeys, в DE - указатель на процедуру
	JP NZ, call_script_call; если флаг не 0 то клавиша есть
	POP HL
	JP process

call_script_me:
  mLDE
	PUSH HL
call_script_call:
	EX DE, HL
	CALL process
call_script_ret:
	POP HL
	JP process

	; честно стырено из движка Wanderers
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

start:
  LD HL, START_SCRIPT
process:
  MemSetScriptBank
  LD A, (HL)
  AND A; _endByte -> 0
  RET Z
  LD E,A
  INC HL
  LD D,(HL)
  INC HL
  LD (process_goto+1), DE
process_goto:
  JP #0000 // в DE - указатель на данные

ENDMODULE
