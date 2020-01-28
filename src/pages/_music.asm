    MODULE Music
INIT:
    ld hl, music
    jp Player.INIT
PLAY: equ Player.PLAY
    ENDMODULE

    MODULE Player
    include "../../engine/routines/utils/PTSPLAY.asm"
    ENDMODULE

music:
    incbin "../../data/music/EA - Epilogue (ea2org) (2020).pt3"
    incbin "../../data/music/keyjee.pt3"
