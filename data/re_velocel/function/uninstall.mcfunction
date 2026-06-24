scoreboard objectives remove re_velocel

scoreboard objectives remove re_velocel_posX
scoreboard objectives remove re_velocel_posY
scoreboard objectives remove re_velocel_posZ

scoreboard objectives remove re_velocel_velX
scoreboard objectives remove re_velocel_velY
scoreboard objectives remove re_velocel_velZ

scoreboard objectives remove re_velocel_accelX
scoreboard objectives remove re_velocel_accelY
scoreboard objectives remove re_velocel_accelZ

scoreboard objectives remove re_velocel_velFB
scoreboard objectives remove re_velocel_velRL

scoreboard objectives remove re_velocel_accelFB
scoreboard objectives remove re_velocel_accelRL

scoreboard objectives remove re_velocel_velAngleYaw
scoreboard objectives remove re_velocel_velAnglePitch

scoreboard objectives remove re_velocel_accelAngleYaw
scoreboard objectives remove re_velocel_accelAnglePitch

scoreboard objectives remove re_velocel_velTotal
scoreboard objectives remove re_velocel_accelTotal

kill 7bd848b4-0c9f-4328-912b-9a2b7244b2de
kill 55ea1109-c187-e66c-94cc-59615a1a1555

data remove storage re_velocel: calc

# これ消しちゃうと逆に困りそうだからこれだけは消すなら手動でお願いします。
# forceload add 0 0

tellraw @a "re_velocel was successfully uninstalled."