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
  CallCode look_char
  ProcessKeysWait keytable
  ; CallCode blue_border
  ; CallCode copy_map
  ; CallCode black_border
  ; CallCode wait
  GoTo LOOP_SCRIPT
  defb _endByte

keytable:
  KEY_Q, BUTTON_UP
  KEY_A, BUTTON_DOWN
  KEY_O, BUTTON_LEFT
  KEY_P, BUTTON_RIGHT
  KEY_M, BUTTON_FIRE 
  defb _endByte