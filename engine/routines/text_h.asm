; печать текста сверху экрана
  MACRO PrintScreen paper, pen, text
      dw text.print_screen_me
      db paper or pen
      dw text
  ENDM
