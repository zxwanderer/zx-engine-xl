  CallCode black_border
  CallCode clear_screen
  ; PrintScreen PAPER_BLACK, PEN_GREEN, HELLO_TXT
  ; CallCode copy_map
  ; CallCode show_map
LOOP_SCRIPT:
  CallCode blue_border
  CallCode black_border
  CallCode wait
  GoTo LOOP_SCRIPT
  defb _endByte
