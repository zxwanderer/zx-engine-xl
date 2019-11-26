 MODULE boot

 macro	sectors datab,datae
   db 1,5,(1+high (datae-datab))
 endm

// не используем JP :(

Basic:
 db #00,#01;номер строки
 DW EndLine1 - Line1
Line1:
 db #EA;REM
 ld sp,#5FFE

  di
  ld de,(#5CF4)
  ld hl, #C000
  ld a,#17,bc,#7FFD:out (c),a
  sectors page0b,page0e
  call #3d13
  ld a,#08,bc,#7FFD:out (c),a
  di
  halt
  
  db "yo,lamer!"
  db #0D
EndLine1:

  db #00,#02
  DW EndLine2 - Line2
Line2:
  db #20,#FD,#B0
  db #22,#32,#34,#35,#37,#35,#22;clear val "24575"
  db #3A; :
  db #F9,#C0,#28,#35;randomize usr (5+256*peek val "23635"+peek val "23636"
  db #0E,#00,#00,#05,#00,#00,#2B
  db #32,#35,#36
  db #0E,#00,#00,#00,#01,#00,#2A,#BE

  db #B0
  db #22,#32,#33,#36,#33,#36,#22;"23635"
  db #2B;???
  db #BE
  db #B0
  db #22,#32,#33,#36,#33,#35,#22;"23636"
  db #29,#0D;)
  db #80
  db #AA,1,0;;;;;;;;;;;;;autorun line,change program length to -4, e.g. 83-4=79
EndLine2:
EndBasic:
 ENDMODULE
