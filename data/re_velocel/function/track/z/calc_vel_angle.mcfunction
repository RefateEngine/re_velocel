execute store result entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Pos[0] double 0.001 run scoreboard players get @s re_velocel_velX
execute store result entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Pos[2] double 0.001 run scoreboard players get @s re_velocel_velZ

execute as 55ea1109-c187-e66c-94cc-59615a1a1555 at @s run rotate @s facing entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de feet
execute store result score @s re_velocel_velAngle run data get entity 55ea1109-c187-e66c-94cc-59615a1a1555 Rotation[0] 10