BEGIN_SCRIPT:
  printScreen PAPER_BLACK, PEN_GREEN, HELLO_TXT
  CallCode copy_map
LOOP_SCRIPT:
  CallCode random_border
  CallCode show_map
  GoTo LOOP_SCRIPT
  defb _endByte
