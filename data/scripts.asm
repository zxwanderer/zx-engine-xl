BEGIN_SCRIPT:

LOOP_SCRIPT:
  CallCode change_border_bin
  GoTo LOOP_SCRIPT
  defb _endByte

change_border_bin:
    ld a,(last_border)
    inc a
    ld (last_border),a
    and %00000111
    out (#fe), a
    ret

last_border: defb 0
