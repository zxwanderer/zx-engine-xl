 MODULE boot

include "../defines.asm"

 macro	sectors datab,datae
   db 1,5,(1+high (datae-datab)) ; ld bc, #__05
 endm

  macro calc_sectors databegin, dataend, result
result equ (1+high (dataend-databegin))
  endm

; basic time now
  ORG 23867 ; Basic with TR-DOS

Basic:
  db #00,#01;номер строки
  DW EndLine1 - Line1
Line1:
  db #EA;REM
  ld sp,#5FFE

; -- порядок файлов:
; code   #6000
; music  #C000 Slot3 Page6
; screen #C000 Slot3 Page7
  
  ; calc_sectors page0b,page0e, page0Len
  calc_sectors  begin_code, end_code, lenCode
  calc_sectors  begin_screen, end_screen, lenScreen
  calc_sectors  begin_music, end_music, lenMusic

  DISPLAY "sectorsCode:   ", /D, lenCode
  DISPLAY "sectorsScreen: ", /D, lenScreen
  DISPLAY "sectorsMusic:  ", /D, lenMusic

  LD A, lenCode
  LD DE, #6000
  call load_and_unpack

  LD A, lenScreen
  LD DE, #4000
  call load_and_unpack

  LD DE, muzBank*256 + lenMusic
  call load_page

  JP #6000
  ; di
  ; halt

; загрузка в страницу памяти
; D - номер страницы, E - число секторов
load_page:
  ld a,d
  ld bc,#7FFD
  out (c),a; переключение нужной страницы через порт
  ld a, e
  ld de, #C000

; Вход:
; DE - куда распаковывать
; A - число секторов
; Процедура пользуется буфером #8000 для загрузки с диска
load_and_unpack:
  push de
  ld (set_sectors), a
  ld de,(#5CF4); номер последнего считанного сектора
  ld hl, #8000
set_sectors equ $+2
  LD BC, #0005
  call #3d13
  pop de
  ld hl, #8000
unpacker:
  include "zx7.a80"

  db "yo,lamer!"
  db #0D
EndLine1:

  db #00,#02
  DW EndLine2 - Line2
Line2:
  db #20,#FD,#B0
  db #22,#32,#34,#35,#37,#35,#22;clear val "24575"
  db #3A; :
  db #F9,#C0,#28,#35;randomize usr (5+256*peek val "23635"+peek val "23636"
  db #0E,#00,#00,#05,#00,#00,#2B
  db #32,#35,#36
  db #0E,#00,#00,#00,#01,#00,#2A,#BE

  db #B0
  db #22,#32,#33,#36,#33,#36,#22;"23635"
  db #2B;???
  db #BE
  db #B0
  db #22,#32,#33,#36,#33,#35,#22;"23636"
  db #29,#0D;)
  db #80
  db #AA,1,0;;;;;;;;;;;;;autorun line,change program length to -4, e.g. 83-4=79
EndLine2:
EndBasic:
 ENDMODULE
