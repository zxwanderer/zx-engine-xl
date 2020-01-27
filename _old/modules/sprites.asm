    MODULE sprites
; ----- показать один спрайт на экране ( для эффектов )
; в DE - экранная позиция
; в A - номер спрайта
show_sprite:
    CALL Tiles16.spr_index_to_addr; в HL у нас указатель на спрайт
    CALL math.pos_scr
    JP Tiles16.show_tile_on_map
    RET

    ENDMODULE
