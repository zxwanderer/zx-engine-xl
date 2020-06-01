MODULE Entities

; для корректного вызова скрипта обработки предмета 
; нужно знать откуда брать его id - 
;       предмет может быть в руках персонажа
;       предмет может лежать на карте
;       или это может быть просто ячейка карты
; поэтому все это придется закодировать в CharDo
; а все богатство возможных последствий придется закодировать в 
; скриптах

  MACRO CharRotMove dir_p
    defw Entities.char_rot_move_me
    defb dir_p
  ENDM

  MACRO CharDoDir action_p
    defw Entities.char_do_dir_me
    defb action_p
  ENDM

activePersonage_ptr:
  dw #0000 ; указатель на данные текущего персонажа
CurPersonageNum:
  db #00 ; текущий номер персонажа ( от 0 до PersonagesNum )
MapCell_ptr:
  dw #0000 ;указатель на ячейку карты на которую воздействует персонаж ( заполняется в процедуре charCheckAction )
ActiveItem_ptr:
  dw #0000 ; указатель на используемый предмет
ActiveItem_ptr_ground:
  dw #0000 ; указатель на используемый предмет на земле

; ------- инициализация на карте всех персонажей из CHAR_SET
initHeroes:
  LD HL, CHARS_SET
PersonagesNum_ptr:
  LD B, PersonagesNum
init_loop: ; пробегаемся по всем персонажам и размещаем их на карте
  LD DE, Hero
  PUSH BC
  PUSH DE
  PUSH HL

  PUSH HL
  POP IX

  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  call map.calc_pos
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  LD A,(IX+Hero.sprite)
  LD (HL),A ; ставим спрайт персонажа на карту
  POP HL
  POP DE
  POP BC
  ADD HL, DE
  DJNZ init_loop
  JR firstChar

; ------- циклический переход на следующего героя ( если был последний то на первого )
loopNextChar:
  CALL nextChar
  RET NZ
firstChar:
  LD DE, CHARS_SET
  ld (activePersonage_ptr), DE
  XOR A
  LD (CurPersonageNum), A
  RET

nextChar:
  LD A, (CurPersonageNum)
  INC A
  CP PersonagesNum
  RET Z; если у нас обнулился счетчик - возвращаемся
  LD (CurPersonageNum), A
  LD DE, (activePersonage_ptr)
  LD HL, Hero
  ADD HL, DE
  LD (activePersonage_ptr), HL
  OR 2
  RET

; ------- показать карту с текущим персонажем на экране
lookChar:
  LD IX, (activePersonage_ptr)
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  LD A, (IX+Hero.dir)
  CALL View.look
  JP View.draw

char_rot_move_me:
  mLDB
  PUSH HL
  CALL char_rot_move
  POP HL
  JP zxengine.process

; вертим героя в нужном направлении или двигаем если уже смотрим в этом направлении
; в B - направление
char_rot_move:
  LD IX, (activePersonage_ptr)
  LD A, (IX+Hero.dir)
  CP B
  JR NZ, char_not_move
  LD C, A
  LD B, do_stand
  JP char_do
char_not_move:
  LD A, B
  LD (IX+Hero.dir), B
  ; CALL Entities.lookCharSeeCellInfo
  JP char_update_sprite

char_do:
  RET

; -------------------------------------------------------------------
; меняем спрайт героя в зависимости от направления персонажа ( в IX указатель на героя )
; -------------------------------------------------------------------
char_update_sprite:
  LD B,(IX+Hero.base_spr)
  LD A,(IX+Hero.dir)
  ADD A, B
  LD (IX+Hero.sprite), A
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  CALL map.calc_pos             ; определяем координаты позиции персонажа в HL
  LD A, (IX+Hero.sprite)
  LD (HL),A                     ; ставим спрайт персонажа на карту
  RET

ENDMODULE
