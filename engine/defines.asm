; файл определений, 
; никаких данных только дефайны и макросы!

_endByte equ 0

PEN_BLACK     equ %000
PEN_BLUE      equ %001
PEN_RED       equ %010
PEN_PURPLE    equ %011
PEN_GREEN     equ %100
PEN_CYAN      equ %101
PEN_YELLOW    equ %110
PEN_WHITE     equ %111

PAPER_BLACK   equ %000000
PAPER_BLUE    equ %001000
PAPER_RED     equ %010000
PAPER_PURPLE  equ %011000
PAPER_GREEN   equ %100000
PAPER_CYAN    equ %101000
PAPER_YELLOW  equ %110000
PAPER_WHITE   equ %111000

SCREEN_ADDR equ #4000
ATTR_ADDR EQU SCREEN_ADDR+#1800

START_SCRIPT equ #C000

scrHeight equ 12-1
scrWidth equ 16
mapSize equ 32

; mempages
gfxBank equ #10   //0 - графика
scrBank equ #11   //1 - скрипты
                  //2 - дублирование #8000
textBank equ #13  //3 - страница текстовых сообщений
mapBank  equ #14  //4 - карта
                  //5 - дублирование #4000
                  //6
muzBank  equ #17  //7 - screen ?

MACRO mLDA
  LD A, (HL)
  INC HL
ENDM

MACRO mLDB
  LD B, (HL)
  INC HL
ENDM

MACRO mLDE ;LD DE, (HL)
  LD E, (HL)
  INC HL
  LD D, (HL)
  INC HL
ENDM

MACRO mLBC ;LD BC, (HL)
  LD C, (HL)
  INC HL
  LD B, (HL)
  INC HL
ENDM

MACRO ret_true
  SCF ; устанавливаем бит переноса ( Carry = 1 )
  RET
ENDM

MACRO ret_false
  SCF ; устанавливаем бит переноса и инвертируем его ))
  CCF
  RET
ENDM

