BEGIN_SCRIPT:

LOOP_SCRIPT:
  CallCode change_border_bin
  GoTo LOOP_SCRIPT
  defb _endByte

change_border_bin:
    ld a,r
    and %00000111
    out (#fe), a
    ret
