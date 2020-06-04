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
  JP char_update_sprite

; в B - action
char_do_dir:
  LD IX, (activePersonage_ptr)
  LD C, (IX+Hero.dir)
; ----- текущий персонаж на что-то воздействует ----
; на входе 
; activePersonage_ptr указатель на персонажа
; в B - действие
; в C - направление
; --------------------------------------------------
char_do:
  LD A, B
  setVar vars.var_act

  LD A,C
  CALL calc_action_pos
  RET NC;  возвратили false - неправильное направление или действие
; Vars.MapCell_xy - позиция, MapCell_ptr - указатель на ячейку

  getVar vars.var_act

  CP do_stand
  JP Z, char_do_stand; персонаж перемещается туда

  RET

; -------------------------------------------------------------------
; персонаж перемещается на MapCell_xy ( MapCell_ptr тоже установлен )
; -------------------------------------------------------------------
char_do_stand:

  LD IX, (activePersonage_ptr)
  ; LD D, (IX+Hero.pos.x)
  ; LD E, (IX+Hero.pos.y)
  ; CALL map.calc_pos             ; определяем координаты позиции персонажа в HL
  ; LD A,(IX+Hero.ground)         ;
  ; LD (HL),A                     ; и ставим на карту спрайт пола
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  LD A, (IX+Hero.ground)
  CALL map.set_cell

  LD DE, ( vars.MapCell_xy )
  LD (IX+Hero.pos.x), D
  LD (IX+Hero.pos.y), E
  CALL map.get_cell
  ; LD HL,( MapCell_ptr )
  ; LD A,(HL)
  LD (IX+Hero.ground),A         ; ячейку карты ставим на пол персонажа

  LD A, (IX+Hero.sprite)
  CALL char_set_cell
  ; LD (HL),A                     ; ставим спрайт персонажа на карту
  ; CALL Entities.lookCharSeeCellInfo
  RET

; --------------------------------------------------------------------------------------
; меняем спрайт героя в зависимости от направления персонажа ( в IX указатель на героя )
; --------------------------------------------------------------------------------------
char_update_sprite:
  LD B,(IX+Hero.base_spr)
  LD A,(IX+Hero.dir)
  ADD A, B
  LD (IX+Hero.sprite), A
char_set_cell:
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  LD A, (IX+Hero.sprite)
  CALL map.set_cell
  RET

  MACRO m_check_left:
    LD A,D
    DEC A
    JP M, check_act_no
    LD D,A
  ENDM

  MACRO m_check_right:
    LD A,D
    INC A
    CP mapSize
    JR NC, check_act_no
    LD D,A
  ENDM

  MACRO m_check_up:
    LD A,E
    DEC A
    JP M, check_act_no
    LD E,A
  ENDM

  MACRO m_check_down:
    LD A,E
    INC A
    CP mapSize
    JP NC, check_act_no
    LD E,A
  ENDM

; вычисляем ячейку на которую действует персонаж по позиции персонажа и направлению
; на входе 
;       activePersonage_ptr указатель на персонажа
;       A - направление 
; на выходе если NС то ошибка ( выход за пределы карты или непонятное действие)
; иначе в DE и MapCell_xy позиция действия, MapCell_ptr - указатель на ячейку карты
calc_action_pos:
  LD IX, (activePersonage_ptr)
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)

calc_action_pos_de: ; а вдруг кто-нибудь сразу сюда полезет? :)
  CP dir_up
  JR Z, check_up
  CP dir_down
  JR Z, check_down
  CP dir_left
  JR Z, check_left
  CP dir_right
  JR Z, check_right

  CP dir_down_left
  JR Z, check_down_left
  CP dir_down_right
  JR Z, check_down_right
  CP dir_up_left
  JR Z, check_up_left
  CP dir_up_right
  JR Z, check_up_right

  CP dir_center
  JR Z, check_center

check_act_no:
  ret_false
  
check_down_left:
  m_check_down
  m_check_left
  JR check_act_yes

check_down_right:
  m_check_down
  m_check_right
  JR check_act_yes

check_up_left:
  m_check_up
  m_check_left
  JR check_act_yes

check_up_right:
  m_check_up
  m_check_right
  JR check_act_yes

check_up:
  m_check_up
  JR check_act_yes

check_down:
  m_check_down
  JR check_act_yes

check_left:
  m_check_left
  JR check_act_yes

check_right:
  m_check_right

check_center:
check_act_yes: ; получили в DE новую позицию и в MapCell_ptr указатель на ячейку карты
  LD (vars.MapCell_xy), DE
  CALL map.calc_pos
  LD (MapCell_ptr), HL
  ret_true

; для переходов JR Z - прям сюда )
sys_check_no:
  ret_false

sys_check_yes:
  ret_true

ENDMODULE
