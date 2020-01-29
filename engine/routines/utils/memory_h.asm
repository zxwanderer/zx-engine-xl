    MACRO MemSetScriptBank
        ld a, scrBank
        call Memory.setBank
    ENDM

    MACRO MemSetTextBank
        ld a, textBank
        call Memory.setBank
    ENDM

    MACRO MemSetGraphBank
        ld a, gfxBank
        call Memory.setBank
    ENDM

    MACRO MemSetShadowBank
        LD A, (Memory.cur_scr+1)
        AND %00001000
        ; JR NC, _set_5
; _set_7:        
        ; LD A, #17
        ; call Memory.setBank
        ; RET
_set_5:        
        LD A, #15
        call Memory.setBank
        RET
    ENDM

    MACRO MemSetMuzBank
        ld a, muzBank
        call Memory.setBank
    ENDM

    MACRO MemSetMapBank
        ld a, mapBank
        call Memory.setBank
    ENDM

    MACRO MemSetBank bank_
        ld a, bank_
        call Memory.setBank
    ENDM
