    ORG #C000

    MODULE Music
INIT:
    ld hl, music
    jp Player.INIT
PLAY: equ Player.PLAY
    ENDMODULE

    MODULE Player
    include "../engine/routines/PTSPLAY.asm"
    ENDMODULE

music:
    incbin "../data/music/keyjee.pt3"
