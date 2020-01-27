BEGIN_SCRIPT:
  CallCode black_border
  printScreen PAPER_BLACK, PEN_GREEN, HELLO_TXT
  CallCode copy_map
LOOP_SCRIPT:
  CallCode show_map
  GoTo LOOP_SCRIPT
  defb _endByte
