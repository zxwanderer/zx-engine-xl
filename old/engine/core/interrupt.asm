  MODULE interrupt

init: ;инициализация прерываний, из Survivesection
  DI
  LD HL,INT_VECTOR
  LD B,0
  LD A, (high INT_VECTOR)+1
init_loop:
  LD (HL),A
  INC HL
  DJNZ init_loop
  LD (HL),A
  LD H,(high INT_VECTOR)+1
  LD L,H
  LD (HL),#C3
  INC HL
  LD DE,interrupt_routine
  LD (HL),E
  INC HL
  LD (HL),D
  LD A,high INT_VECTOR
  LD I,A
  IM 2
  EI
  RET

interrupt_routine:
  DI
	PUSH af,bc,de,hl
	EXX
	EXA
	PUSH af,bc,de,hl,ix,iy
  
  ; LD A,R
  ; OUT(#FE),A

  LD HL, (frame_counter)
  INC HL
  LD (frame_counter), HL

return_routine:
	POP iy,ix,hl,de,bc,af
	EXX
	EXA
	POP hl,de,bc,af
	EI
  RET

frame_counter:
  dw 0

interrupt_end
  ENDMODULE
