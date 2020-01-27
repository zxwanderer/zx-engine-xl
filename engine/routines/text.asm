MODULE text

print_screen_me:
    PUSH HL
    CALL input.noKey
    CALL screen.clear; очищаем экран
    POP HL
    mLDA; загрузили цвет
    PUSH HL
    CALL screen.set_colors
    POP HL
    mLDE
    PUSH HL
    LD HL, SCREEN_ADDR
    EX HL, DE
    MemSetTextBank
    CALL Text68.print_68at
    POP HL
    JP zxengine.process

  ; На входе
  ; в DE координаты XY
  ; в HL - указатель на текст
; print_at:
;   CALL math.pos_scr; рассчитали адрес на экране по координатам
;   CALL Text68.print_68at
;   RET

ENDMODULE
