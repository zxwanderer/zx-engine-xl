; бинарные процедуры вызываемые из скриптов которые требуют переключения памяти

wait:
  HALT
  ret

clear_screen:
  xor a
  call screen.set_colors
  call screen.clear
  ret

black_border:
  XOR A
  AND %00000111
  out(#fe),a
  ret

blue_border:
  LD A, 1
  out(#fe),a
  ret

random_border:
  LD A, R
  AND %00000111
  out(#fe),a
  ret

copy_map:
  MemSetMapBank
  LD HL, MAP_SET
  CALL View.copy
  ret

show_map:
  MemSetGraphBank
  CALL View.draw
  ret

draw_sprite:
    LD HL, (view_addr)
    LD DE, (screen_addr)

    LD A,(HL)
no_get_a:
    INC A
    CP #98 ; #B4 ;#98
    JR C, no_reset_a

    LD A, R
    CP #75
    JR C, set_default_a
    LD A, #90
    JR no_reset_a

set_default_a:
    LD A, #90 ; #B0 ;#90
no_reset_a:
    LD (HL), A
    INC HL
    LD (view_addr), HL

    call Tiles16.spr_index_to_addr
    call Tiles16.show_tile_on_map

    LD A, (pos_x)
    DEC A
    JR Z, reset_loop

no_reset_loop:
    LD (pos_x), A
    LD DE, (screen_addr)
    Tiles16.NEXT_TILE_POS_RIGHT
    LD (screen_addr), DE
    RET

reset_loop:
    LD A, (pos_y)
    DEC A
    JR Z, reset_pos_y_x

reset_pos_x:
    LD (pos_y), A
    LD A, max_x
    LD (pos_x), A
    LD DE, (screen_addr_begin)
    Tiles16.NEXT_TITLE_POS_DOWN
    LD (screen_addr_begin), DE
    LD (screen_addr), DE
    RET

reset_pos_y_x:
    LD DE, screen_addr_default
    LD (screen_addr_begin), DE
    LD (screen_addr), DE
    LD A, max_y
    LD (pos_y), A
    LD A, max_x
    LD (pos_x), A
    LD HL, view_addr_default
    LD (view_addr), HL
    ; CALL Memory.flipScreen
    RET

max_x equ 16; scrWidth
max_y equ 11 ; scrHeight
view_addr_default equ temp_buffer ;View.buffer
screen_addr_default: equ SCREEN_ADDR

pos_x: defb max_x
pos_y: defb max_y
view_addr: defw view_addr_default
screen_addr: defw screen_addr_default
screen_addr_begin: defw screen_addr_default

temp_buffer:
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
  defb #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90, #90
