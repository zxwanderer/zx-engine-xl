; перейти на метку скрипта
  MACRO GoTo addr
    defw zxengine.goto_me
    defw addr
  ENDM

; вызвать исполняемый код
  MACRO CallCode ptr
    defw zxengine.call_code_me
    defw ptr
  ENDM

; вызвать скрипт
  MACRO CallScript ptr
    defw zxengine.call_script_me
    defw ptr
  ENDM

; обработать нажатие клавиши и подождать пока отпустит
  MACRO ProcessKeysWait addr
    defw zxengine.process_keys_wait_me
    defw addr
  ENDM

; обработать нажатие клавиши и подождать пока отпустит
  MACRO ProcessButtons addr
    defw zxengine.process_buttons_me
    defw addr
  ENDM
