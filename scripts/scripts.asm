  CallCode black_border
  CallCode clear_screen
  PrintScreen PAPER_BLACK, PEN_GREEN, HELLO_TXT
  ProcessKeysWait keytable
  
  CallCode game_init
  ; CallCode copy_map
  ; CallCode input.waitKey
  ; CallCode input.noKey
  ; CallCode show_map
  CallCode look_char
LOOP_SCRIPT:
  CallCode look_char
  ; CallCode black_border
  ; CallCode look_char
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
  CharRotMove dir_up
  CallCode blue_border
  defb _endByte

proc_BUTTON_DOWN:
  CharRotMove dir_down
  CallCode blue_border
  defb _endByte

proc_BUTTON_LEFT:
  CharRotMove dir_left
  CallCode blue_border
  defb _endByte

proc_BUTTON_RIGHT:
  CharRotMove dir_right
  CallCode green_border
  defb _endByte

proc_BUTTON_FIRE:
  CallCode red_border
  defb _endByte
