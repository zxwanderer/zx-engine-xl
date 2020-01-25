BEGIN_SCRIPT:
  CallCode clear_screen_bin
  printScreen PAPER_BLACK, PEN_GREEN, HELLO_TXT
LOOP_SCRIPT:
  CallCode random_border
  GoTo LOOP_SCRIPT
  defb _endByte

random_border:
  ld a, r
  AND %00000111
  out(#fe),a
  ret

MAP:
  db 00

sprite:
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111

  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111
  db %11111111, %11111111

clear_screen_bin:
  CALL screen.clear
  LD A, %00111000
  CALL screen.set_colors
  RET
