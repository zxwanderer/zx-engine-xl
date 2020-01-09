BEGIN_SCRIPT:

LOOP_SCRIPT:
  ; CallCode wait_halt_bin
  CallCode change_border_bin
  ; CallCode move_screen_left
  GoTo LOOP_SCRIPT
  defb _endByte

; wait_halt_bin:
  ; halt
  ; ret

change_border_bin:
    ld a,(last_border)
    inc a
    ld (last_border),a
    and %00000111
    out (#fe), a
    ret

last_border: defb 0

cur_screen_addr: defw SCREEN_ADDR
cur_row: defb 192

move_screen_left:
  LD HL,(cur_screen_addr)
  call move_row_left
  LD (cur_screen_addr), HL
  LD A,(cur_row)
  DEC A
  JR Z, init_screen_left
  LD (cur_row), A
  RET
init_screen_left:
  LD HL, SCREEN_ADDR
  LD (cur_screen_addr), HL
  LD A, 192
  LD (cur_row), A
  HALT
  RET

; на входе HL указатель на начало строки пикселей от 0 до 192
move_row_left:
  LD B,31
NEXT_B:
  INC HL
  LD E,(HL)
  DEC HL
  LD (HL),E
  INC HL
  DJNZ NEXT_B
  RET
