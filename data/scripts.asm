BEGIN_SCRIPT:
  CallCode clear_screen_bin
LOOP_SCRIPT:
  CallCode wait_bin
  CallCode red_border_bin
  CallCode process_logic_bin
  CallCode blue_border_bin
  CallCode process_logic_bin
  GoTo LOOP_SCRIPT
  defb _endByte


SCREEN_PTR equ #6000

process_logic_bin:
  ld b, #ff
logic_loop:
  DJNZ logic_loop
  ret

wait_bin:
  halt
  ret

red_border_bin:
  ld a, 1
  out(#fe),a
  ret

blue_border_bin:
  ld a, 2
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
  LD HL, SCREEN_ADDR
  LD DE, SCREEN_ADDR + 1
  LD BC, 6144
  LD (HL), %00000000
  LDIR

  LD HL, ATTR_ADDR
  LD DE, ATTR_ADDR + 1
  LD BC, 768
  LD (HL), %00111000
  LDIR

  RET

 

; print_map:
;        LD     (SP_+1),SP
;        LD      IX,OUTS
;        LD      DE, #C000 // АДРЕС В КАРТЕ
;        EXX
;        LD      BC,#6000;АДРЕС БУФЕРНОГО
;        EXX              ;ЭКРАНА
;        LD      IX,OUTS
;        LD      B, 2 //ЧИСЛО СПРАЙТОВ ПО Y
; LOOP   LD      HL,$+3
;       ;  !ASSM   ЧИСЛО СПРАЙТОВ ПО X
;        JP      (IX)
;        JP      (IX)
;       ;  !CONT
; ;ВАША  ПРОЦЕДУРА  ПЕРЕХОДА К СЛЕД.ГОРИЗОН-
; ;ТАЛЬНОЙ ЛИНИИ,И ПЕРЕХОДА К СЛЕД.ПАРЕ ЗНА-
; ;КОМЕСТ ЭКРАНА
;        DJNZ    LOOP
; SP_    LD      SP,0
;        RET

; OUTS   LD      A,(DE)
;        EXX
;        ADD     A,A
;        LD      L,A
;        LD      H, #2000 // SPR_TBL&H;СТАРШИЙ БАЙТ
;   ;ЗАРАНЕЕ ПОДГОТОВЛЕННОЙ ТАБЛИЦЫ АДРЕСОВ
;   ;(ДЛЯ  СОЗДАНИЯ  СТАТИЧНОЙ АНИМАЦИИ ДОСТА-
;   ;ТОЧНО ЛИШЬ МЕНЯТЬ ЕГО СНАЧЕНИЕ)
;        LD      SP,HL
;        POP     HL
;        LD      SP,HL;ВЗЯЛИ АДРЕС СПРАЙТА
;        LD      H,B
;        LD      L,C;В HL-АДРЕС ДЛЯ ПЕЧАТИ
; ;
;       ;  !ASSM   3
;       DUP 3
;        POP     DE
;        LD      (HL),E
;        INC     L
;        LD      (HL),D
;        INC     H
;        POP     DE
;        LD      (HL),D
;        DEC     L
;        LD      (HL),E
;        INC     H
;       ;  !CONT
;       EDUP
;        POP     DE
;        LD      (HL),E
;        INC     L
;        LD      (HL),D
;        INC     H
;        POP     DE
;        LD      (HL),D
;        DEC     L
;        LD      (HL),E;НАПЕЧАТАЛИ ВЕРХНЮЮ
; ;                     ПОЛОВИНУ

;        LD      A,#20
;        ADD     A,L
;        LD      L,A;ПЕРШЛИ К НИЖНЕЙ

;       ;  !ASSM   3;ПЕЧАТАЕМ НИЗ...
;        DUP 3
;        POP     DE
;        LD      (HL),E
;        INC     L
;        LD      (HL),D
;        DEC     H
;        POP     DE
;        LD      (HL),D
;        DEC     L
;        LD      (HL),E
;        DEC     H
;        EDUP
;       ;  !CONT
;        POP     DE
;        LD      (HL),E
;        INC     L
;        LD      (HL),D
;        DEC     H
;        POP     DE
;        LD      (HL),D
;        DEC     L
;        LD      (HL),E
;        INC     C;НЕОБХОДИМЫЕ
;        INC     C;КОРРЕКТИРОВКИ...
;        EXX
;        INC     E
;        INC     HL
;        INC     HL
;        JP      (HL);ВЫХОД

; wait_halt_bin:
  ; halt
  ; ret

; init_bin:
;   ; ld a, #ff
;   ; ld (last_border_and), a
;   ret

change_border_bin:
  ; ld a,(last_border)
  ; inc a
  ; ld (last_border),a
  ; and %00000111 ;  grb
  ld a, 2
  out (#fe), a
  ret

last_border: defb 0
; last_border_and: defb 0

; cur_screen_addr: defw SCREEN_ADDR
; cur_row: defb 192

; screen_changer:
; scr:
  ; LD      A,#55       ; %O1O1O1O1
  ; RRCA                            
  ; LD      (scr+1),A               
  ; LD      A,#17       ; 16+7      
  ; JR      C,PAGER
  ; LD      A,#1D       ; 24+5      
; PAGER:                                  
  ; LD      BC,#7FFD    ; 32765     
  ; OUT     (C),A                   
  ; RET         

; clear_attr:
;   LD HL, ATTR_ADDR
;   LD DE, ATTR_ADDR + 1
;   LD BC, 768
;   LD (HL), %00000111
;   LDIR
;   RET

; move_screen_left:
;   LD HL,(cur_screen_addr)
;   call move_row_left
;   LD (cur_screen_addr), HL
;   LD A,(cur_row)
;   DEC A
;   JR Z, init_screen_left
;   LD (cur_row), A
;   RET
; init_screen_left:
;   LD HL, SCREEN_ADDR
;   LD (cur_screen_addr), HL
;   LD A, 192
;   LD (cur_row), A
;   HALT
;   RET

; на входе HL указатель на начало строки пикселей от 0 до 192
; move_row_left:
;   LD B,31
; NEXT_B:
;   INC HL
;   LD E,(HL)
;   DEC HL
;   LD (HL),E
;   INC HL
;   DJNZ NEXT_B
;   RET
