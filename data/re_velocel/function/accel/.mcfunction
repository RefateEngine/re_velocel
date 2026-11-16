#> re_velocel:accel/
# 実行者の加速度の合計絶対値と角度を計算する
# 同じtickの re_velocel:track/ の後に実行する
#
# 更新する値:
#   re_velocel.accel.total / angle_yaw / angle_pitch

# 水平の合計絶対値 |x| + |z| (yawのデッドゾーン判定に使う)
scoreboard players set #_re_velocel.accel.e3.totalXz re_velocel.tmp 0
execute if score @s re_velocel.accel.x matches 1.. run scoreboard players operation #_re_velocel.accel.e3.totalXz re_velocel.tmp += @s re_velocel.accel.x
execute if score @s re_velocel.accel.x matches ..-1 run scoreboard players operation #_re_velocel.accel.e3.totalXz re_velocel.tmp -= @s re_velocel.accel.x
execute if score @s re_velocel.accel.z matches 1.. run scoreboard players operation #_re_velocel.accel.e3.totalXz re_velocel.tmp += @s re_velocel.accel.z
execute if score @s re_velocel.accel.z matches ..-1 run scoreboard players operation #_re_velocel.accel.e3.totalXz re_velocel.tmp -= @s re_velocel.accel.z

# 合計絶対値 |x| + |y| + |z|
scoreboard players operation @s re_velocel.accel.total = #_re_velocel.accel.e3.totalXz re_velocel.tmp
execute if score @s re_velocel.accel.y matches 1.. run scoreboard players operation @s re_velocel.accel.total += @s re_velocel.accel.y
execute if score @s re_velocel.accel.y matches ..-1 run scoreboard players operation @s re_velocel.accel.total -= @s re_velocel.accel.y

# デッドゾーンを超えていれば角度を更新する
execute if score @s re_velocel.accel.total >= #re_velocel.e3.ANGLE_DEADZONE re_velocel.const run function re_velocel:accel/z/angle

# ローカル変数のreset
# 毎tick実行が前提で、使う前に必ず代入されるので、負荷を減らすために省略している
# scoreboard players reset #_re_velocel.accel.e3.totalXz re_velocel.tmp
