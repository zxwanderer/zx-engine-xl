MODULE zxengine

MACRO CALL_SCRIPT_HL
  LD E, (HL)
  INC HL
  LD D, (HL)
  INC HL
  PUSH HL
  EX DE, HL
	CALL process
  POP HL
ENDM

process_buttons_me:
  mLDE
  PUSH HL
  EX HL,DE ; в HL указатель на таблицу клавиш
  LD A, (input.pressButtons)
  ; LD A, BUTTON_DOWN
c_up:
  SRL A
  JR NC, c_down
  PUSH AF
  ; CALL_SCRIPT_HL
  POP AF
c_down:
  SRL A
  JR NC, c_left
  PUSH AF
  CALL_SCRIPT_HL
  POP AF
c_left:
  SRL A
  JR NC, c_right
  PUSH AF
  CALL_SCRIPT_HL
  POP AF
c_right:
  SRL A
  JR NC, c_fire
  PUSH AF
  CALL_SCRIPT_HL
  POP AF
c_fire:
  SRL A
  JR NC, c_exit
  PUSH AF
  CALL_SCRIPT_HL
  POP AF
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
