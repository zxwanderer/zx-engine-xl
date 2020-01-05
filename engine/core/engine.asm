MODULE zxengine

  MACRO GoTo addr
    defw zxengine.goto_me
    defw addr
  ENDM

  MACRO CallCode ptr
    defw zxengine.call_code_me
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

start:
  LD HL, START_SCRIPT
process:
  ; halt
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
