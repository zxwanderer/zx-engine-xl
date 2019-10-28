DEVICE 	ZXSPECTRUM128
    ORG	#6000

begin_starter:

end_starter:

LOAD_ADDR equ begin_starter
boot.begin equ LOAD_ADDR
boot.end equ end_starter
boot.START_ADDR equ begin_starter

    include "../engine/routines/basic_boot_trd.asm"
    EMPTYTRD "cell3326.trd" ;create empty TRD image
    SAVETRD "cell3326.trd", "CELL3326.B", boot.Basic, boot.EndBasic - boot.Basic
