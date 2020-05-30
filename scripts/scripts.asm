  CallCode black_border
  CallCode clear_screen
  PrintScreen PAPER_BLACK, PEN_GREEN, HELLO_TXT
  ProcessKeysWait keytable
  
  CallCode game_init
  ; CallCode copy_map
  ; CallCode input.waitKey
  ; CallCode input.noKey
  ; CallCode show_map
LOOP_SCRIPT:
  ; CallCode black_border
  CallCode look_char
  ProcessKeysWait keytable
  ProcessButtons buttons_table
  ; CallCode blue_border
  CallCode black_border
  ; CallCode copy_map
  ; CallCode wait
  GoTo LOOP_SCRIPT
  defb _endByte

keytable:
  KEY_Q
  defb BUTTON_UP
  KEY_A 
  defb BUTTON_DOWN
  KEY_O
  defb BUTTON_LEFT
  KEY_P 
  defb BUTTON_RIGHT
  KEY_M 
  defb BUTTON_FIRE
  defb _endByte

buttons_table:
  defw proc_BUTTON_UP
  defw proc_BUTTON_DOWN
  defw proc_BUTTON_LEFT
  defw proc_BUTTON_RIGHT
  defw proc_BUTTON_FIRE
  defb _endByte

proc_BUTTON_UP:
  CallCode blue_border
  defb _endByte

proc_BUTTON_DOWN:
  CallCode blue_border
  defb _endByte

proc_BUTTON_LEFT:
  CallCode blue_border
  defb _endByte

proc_BUTTON_RIGHT:
  CallCode blue_border
  defb _endByte

proc_BUTTON_FIRE:
  CallCode blue_border
  defb _endByte
