#> re_velocel:load

# ローカル変数・グローバル定数
scoreboard objectives add re_velocel.tmp dummy
scoreboard objectives add re_velocel.const dummy

# 座標
scoreboard objectives add re_velocel.pos.x dummy "X座標(1000倍)"
scoreboard objectives add re_velocel.pos.y dummy "Y座標(1000倍)"
scoreboard objectives add re_velocel.pos.z dummy "Z座標(1000倍)"

# 速度
scoreboard objectives add re_velocel.vel.x dummy "X速度(1000倍)"
scoreboard objectives add re_velocel.vel.y dummy "Y速度(1000倍)"
scoreboard objectives add re_velocel.vel.z dummy "Z速度(1000倍)"
scoreboard objectives add re_velocel.vel.fb dummy "前後速度(1000倍)"
scoreboard objectives add re_velocel.vel.rl dummy "左右速度(1000倍)"
scoreboard objectives add re_velocel.vel.total dummy "速度合計絶対値(1000倍)"
scoreboard objectives add re_velocel.vel.length_xz dummy "水平速度(1000倍)"
scoreboard objectives add re_velocel.vel.angle_yaw dummy "速度角度Yaw(10倍)"
scoreboard objectives add re_velocel.vel.angle_pitch dummy "速度角度Pitch(10倍)"

# 加速度
scoreboard objectives add re_velocel.accel.x dummy "X加速度(1000倍)"
scoreboard objectives add re_velocel.accel.y dummy "Y加速度(1000倍)"
scoreboard objectives add re_velocel.accel.z dummy "Z加速度(1000倍)"
scoreboard objectives add re_velocel.accel.fb dummy "前後加速度(1000倍)"
scoreboard objectives add re_velocel.accel.rl dummy "左右加速度(1000倍)"
scoreboard objectives add re_velocel.accel.total dummy "加速度合計絶対値(1000倍)"
scoreboard objectives add re_velocel.accel.angle_yaw dummy "加速度角度Yaw(10倍)"
scoreboard objectives add re_velocel.accel.angle_pitch dummy "加速度角度Pitch(10倍)"

# 内部状態: 1 = 直前のtickは座標が届かなかったので値を保持した
scoreboard objectives add re_velocel.stall dummy

# 定数
scoreboard players set #re_velocel.-1 re_velocel.const -1
scoreboard players set #re_velocel.2 re_velocel.const 2
scoreboard players set #re_velocel.3 re_velocel.const 3
scoreboard players set #re_velocel.1000 re_velocel.const 1000
# 角度を更新する最小の合計絶対値。これ未満のときは最後の角度を維持する
scoreboard players set #re_velocel.e3.ANGLE_DEADZONE re_velocel.const 35

# 角度計算用マーカーと、その座標を組み立てるストレージ
data modify storage re_velocel: vector set value [0d,0d,0d]
execute in overworld run forceload add 0 0
execute unless entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de run function re_velocel:track/z/summon_marker
