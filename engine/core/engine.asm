MODULE zxengine

process_keys_wait_me:
  mLDE
  PUSH HL
  EX HL,DE ; в HL указатель на таблицу клавиш
  XOR A
  LD (input.pressButtons), A
  CALL input.waitKey
  CALL input.scanKeys
  CALL input.noKey
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
