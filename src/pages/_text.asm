p68_font: equ $
    incbin '../../data/fonts/Font57_revert.fnt'
p68_font_end: equ $

    include '../../data/lang/lang_ru.asm'

    include '../../engine/routines/text68.asm'

_text_stop: equ $
    DISPLAY 'Font addr begin: ', p68_font, ' font size: ', /D, p68_font_end-p68_font
    DISPLAY '-----------------------------------'
