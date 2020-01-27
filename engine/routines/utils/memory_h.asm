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

    MACRO MemSetMapBank
        ld a, mapBank
        call Memory.setBank
    ENDM

    MACRO MemSetBank bank_
        ld a, bank_
        call Memory.setBank
    ENDM
