    MACRO SetIM2 _vector
	  ld hl,intTab
	  ld de,intTab+1
	  ld bc,0x100
	  ld a,h
	  ld i,a
	  ld (hl),high _vector
	  ldir
	  im 2
    ENDM
