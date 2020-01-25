    ORG #C000
p68_font: equ $
    incbin '../data/fonts/Font57_revert.fnt'
p68_font_end: equ $
    include '../engine/routines/text68.asm'

    include '../data/lang/lang_ru.asm'

_text_stop: equ $
    DISPLAY 'Font addr: ', p68_font, ' font size: ', /D, p68_font_end-p68_font
    ; DISPLAY 'Text size: ', /D, _text_end - p68_font
    ; DISPLAY p68_font, ' ', p68_font_end,' ', _text_stop
