scoreboard objectives add re_velocel dummy

scoreboard objectives add re_velocel_posX dummy "X座標(1000倍)"
scoreboard objectives add re_velocel_posY dummy "Y座標(1000倍)"
scoreboard objectives add re_velocel_posZ dummy "Z座標(1000倍)"

scoreboard objectives add re_velocel_velX dummy "X速度(1000倍)"
scoreboard objectives add re_velocel_velY dummy "Y速度(1000倍)"
scoreboard objectives add re_velocel_velZ dummy "Z速度(1000倍)"

scoreboard objectives add re_velocel_accelX dummy "X加速度(1000倍)"
scoreboard objectives add re_velocel_accelY dummy "Y加速度(1000倍)"
scoreboard objectives add re_velocel_accelZ dummy "Z加速度(1000倍)"

scoreboard objectives add re_velocel_velFB dummy "前後速度(1000倍)"
scoreboard objectives add re_velocel_velRL dummy "左右速度(1000倍)"

scoreboard objectives add re_velocel_accelFB dummy "前後加速度(1000倍)"
scoreboard objectives add re_velocel_accelRL dummy "左右加速度(1000倍)"

scoreboard objectives add re_velocel_velAngleYaw dummy "速度角度Yaw(10倍)"
scoreboard objectives add re_velocel_velAnglePitch dummy "速度角度Pitch(10倍)"

scoreboard objectives add re_velocel_accelAngleYaw dummy "加速度角度Yaw(10倍)"
scoreboard objectives add re_velocel_accelAnglePitch dummy "加速度角度Pitch(10倍)"

scoreboard objectives add re_velocel_velTotal dummy "速度合計絶対値(1000倍)"
scoreboard objectives add re_velocel_accelTotal dummy "加速度合計絶対値(1000倍)"



scoreboard players set #re_velocel_scale re_velocel 1000

forceload add 0 0
# 7bd848b4-0c9f-4328-912b-9a2b7244b2de
kill 7bd848b4-0c9f-4328-912b-9a2b7244b2de
summon marker 0.0 0.0 0.0 {UUID:[I;2077771956,211764008,-1859413461,1917104862]}
# 55ea1109-c187-e66c-94cc-59615a1a1555
kill 55ea1109-c187-e66c-94cc-59615a1a1555
summon marker 0.0 0.0 0.0 {UUID:[I;1441403145,-1048058260,-1798547103,1511658837]}
