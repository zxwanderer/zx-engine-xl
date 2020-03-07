PersonagesNum equ 1

Hero09.spr: equ 160

tHeroName2: defb 'Lol kek',0

CHARS_SET: ; описываем героев:
; Hero1: Entities.Hero 31,31, 9, 0, 0, tHeroName2, 00
Hero2: Hero 3,10, 0, Hero09.spr, Hero09.spr, 0, 0, tHeroName2, 00
; Hero2: Hero 9, 27, 0, Scaf.spr, Scaf.spr, 0, 0, tHeroName2, 00
