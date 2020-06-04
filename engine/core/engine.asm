MODULE zxengine

; для использования внутри ассемблера

  MACRO setVar var; заносим значение из A в переменную движка
    LD ( zxengine.varsTab + var ), A
  ENDM

	MACRO getVar var; в A заносим значение переменной движка
    LD A, ( zxengine.varsTab + var )
  ENDM

MACRO SRL_A_AND_CALL_HL
  mLDE
  SRL A
  JR NC, .exit
  PUSH AF
  PUSH HL
  EX DE, HL
	CALL process
  POP HL
  POP AF
.exit  
ENDM

process_buttons_me:
  mLDE ; в DE указатель на таблицу клавиш
  PUSH HL
  EX HL,DE ; в HL указатель на таблицу клавиш
  LD A, (input.pressButtons)
c_up:
  SRL_A_AND_CALL_HL
c_down:
  SRL_A_AND_CALL_HL
c_left:
  SRL_A_AND_CALL_HL
c_right:
  SRL_A_AND_CALL_HL
c_fire:
  SRL_A_AND_CALL_HL
c_exit:
  POP HL
  JP process


process_keys_wait_me:
  mLDE
  PUSH HL
  EX HL,DE ; в HL указатель на таблицу клавиш
  ; CALL input.waitKey
  CALL input.scanKeys
  ; CALL input.noKey
  POP HL
  JP process

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

call_script_me:
  mLDE
	PUSH HL
call_script_call:
	EX DE, HL
	CALL process
call_script_ret:
	POP HL
	JP process

; --- получить значение переменной
; на входе A - номер переменной
; на выходе 
;   в DE - указатель на переменную
;   в A - значение переменной
getVar:
	ld de,varsTab
	mADDA D,E
	ld A,(DE)
	ret

set_var_me:
	mLDA
	CALL getVar
	LD A,(HL)
	INC HL
	LD (DE),A
	JP process

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

; различные переменные для скриптов
varsTab:
  DUP 256
    defb 00
  EDUP

ENDMODULE
