; бинарные процедуры вызываемые из скриптов которые требуют переключения памяти
random_border:
  ld a, r
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

last_sprite: defb 0
