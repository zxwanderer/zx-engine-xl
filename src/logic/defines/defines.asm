dir_down EQU 0
dir_down_left EQU 1
dir_left  EQU 2
dir_up_left EQU 3
dir_up   EQU 4
dir_up_right EQU 5
dir_right  EQU 6
dir_down_right EQU 7
dir_center EQU 8; никуда не двигаем =)

; действия
do_end   EQU #00
do_stand EQU #01
do_get EQU #02
do_drop EQU #3
do_look  EQU #02
do_use   EQU #04
do_smach EQU #05

MODULE vars

MAX_BIOCONTAINERS_FOR_POWER_ON equ 6; максимальное кол-во биоконтейнеров для запуска энергии

; системные переменные в Engine для использования
var_act equ 0; // переменная 0 - действие
var_ret equ 1; // переменная 1 - что возвратили из скрипта
var_pos_y equ 2
var_pos_x equ 3
MapCell_xy equ zxengine.varsTab+var_pos_y; положение воздействия автоматом доступно из скриптов если пишется в переменные Engine =)
var_item_id equ 4; id активного предмета
game_over equ 5; вариант окончания игры
; var_mode equ 8; текущий режим игры: 0 - игрок двигается, 1 - курсор двигается
power_on equ 9; сколько контейнеров подключено в энергостанции
alert_code_found: equ 10; найдены коды активации протокола
ENDMODULE
