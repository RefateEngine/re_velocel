# re_velocel:track/z/calc_vel_angleの後に実行されるのでfailsafeは流石に必要ない

execute store result entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Pos[0] double 0.001 run scoreboard players get @s re_velocel_accelX
execute store result entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Pos[1] double 0.001 run scoreboard players get @s re_velocel_accelY
execute store result entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Pos[2] double 0.001 run scoreboard players get @s re_velocel_accelZ

execute as 55ea1109-c187-e66c-94cc-59615a1a1555 at @s run rotate @s facing entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de feet
data modify storage re_velocel: calc.accelAngle set from entity 55ea1109-c187-e66c-94cc-59615a1a1555 Rotation
