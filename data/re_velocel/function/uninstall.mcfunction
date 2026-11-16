#> re_velocel:uninstall

scoreboard objectives remove re_velocel.tmp
scoreboard objectives remove re_velocel.const

scoreboard objectives remove re_velocel.pos.x
scoreboard objectives remove re_velocel.pos.y
scoreboard objectives remove re_velocel.pos.z

scoreboard objectives remove re_velocel.vel.x
scoreboard objectives remove re_velocel.vel.y
scoreboard objectives remove re_velocel.vel.z
scoreboard objectives remove re_velocel.vel.fb
scoreboard objectives remove re_velocel.vel.rl
scoreboard objectives remove re_velocel.vel.total
scoreboard objectives remove re_velocel.vel.length_xz
scoreboard objectives remove re_velocel.vel.angle_yaw
scoreboard objectives remove re_velocel.vel.angle_pitch

scoreboard objectives remove re_velocel.accel.x
scoreboard objectives remove re_velocel.accel.y
scoreboard objectives remove re_velocel.accel.z
scoreboard objectives remove re_velocel.accel.fb
scoreboard objectives remove re_velocel.accel.rl
scoreboard objectives remove re_velocel.accel.total
scoreboard objectives remove re_velocel.accel.angle_yaw
scoreboard objectives remove re_velocel.accel.angle_pitch

scoreboard objectives remove re_velocel.stall

kill 7bd848b4-0c9f-4328-912b-9a2b7244b2de
data remove storage re_velocel: vector

# RDSG対応前のバージョンが作成したもの
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
scoreboard objectives remove re_velocel_velLengthXZ
kill 55ea1109-c187-e66c-94cc-59615a1a1555
data remove storage re_velocel: calc

# ほかのデータパックが使っている可能性があるので、forceloadの解除は手動でお願いします。
# execute in overworld run forceload remove 0 0

tellraw @a "re_velocel was successfully uninstalled."
