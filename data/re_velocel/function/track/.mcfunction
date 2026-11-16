#> re_velocel:track/
# 実行者の座標・速度・加速度を計算する
# 毎tick実行する必要があります
#
# 更新する値:
#   re_velocel.pos.x / y / z
#   re_velocel.vel.x / y / z / total / length_xz / angle_yaw / angle_pitch
#   re_velocel.accel.x / y / z
# 加速度の合計・角度は re_velocel:accel/ 、視点基準の前後・左右は re_velocel:relative/ を続けて実行する

# 現在座標を取得する
execute at @s summon marker run function re_velocel:track/z/sample

# このtickの移動量
scoreboard players operation #_re_velocel.track.e3.deltaX re_velocel.tmp = #_re_velocel.track.e3.posX re_velocel.tmp
scoreboard players operation #_re_velocel.track.e3.deltaX re_velocel.tmp -= @s re_velocel.pos.x
scoreboard players operation #_re_velocel.track.e3.deltaY re_velocel.tmp = #_re_velocel.track.e3.posY re_velocel.tmp
scoreboard players operation #_re_velocel.track.e3.deltaY re_velocel.tmp -= @s re_velocel.pos.y
scoreboard players operation #_re_velocel.track.e3.deltaZ re_velocel.tmp = #_re_velocel.track.e3.posZ re_velocel.tmp
scoreboard players operation #_re_velocel.track.e3.deltaZ re_velocel.tmp -= @s re_velocel.pos.z

# 動いていたのに座標が全く変わらなかったtickは、移動パケットが届かなかっただけとみなして全ての値を保持する
# 2tick連続で変わらなければ本当に止まったとして扱う
execute if score @s re_velocel.stall matches 0 unless score @s re_velocel.vel.total matches 0 if score #_re_velocel.track.e3.deltaX re_velocel.tmp matches 0 if score #_re_velocel.track.e3.deltaY re_velocel.tmp matches 0 if score #_re_velocel.track.e3.deltaZ re_velocel.tmp matches 0 run return run scoreboard players set @s re_velocel.stall 1

# 保持した次のtickは、届かなかった分もまとめて動いていることがあるので補正する
execute if score @s re_velocel.stall matches 1 run function re_velocel:track/z/catch_up
scoreboard players set @s re_velocel.stall 0

# 座標
scoreboard players operation @s re_velocel.pos.x = #_re_velocel.track.e3.posX re_velocel.tmp
scoreboard players operation @s re_velocel.pos.y = #_re_velocel.track.e3.posY re_velocel.tmp
scoreboard players operation @s re_velocel.pos.z = #_re_velocel.track.e3.posZ re_velocel.tmp

# 加速度 = 新しい速度 - 前の速度
scoreboard players operation @s re_velocel.accel.x = #_re_velocel.track.e3.deltaX re_velocel.tmp
scoreboard players operation @s re_velocel.accel.x -= @s re_velocel.vel.x
scoreboard players operation @s re_velocel.accel.y = #_re_velocel.track.e3.deltaY re_velocel.tmp
scoreboard players operation @s re_velocel.accel.y -= @s re_velocel.vel.y
scoreboard players operation @s re_velocel.accel.z = #_re_velocel.track.e3.deltaZ re_velocel.tmp
scoreboard players operation @s re_velocel.accel.z -= @s re_velocel.vel.z

# 速度
scoreboard players operation @s re_velocel.vel.x = #_re_velocel.track.e3.deltaX re_velocel.tmp
scoreboard players operation @s re_velocel.vel.y = #_re_velocel.track.e3.deltaY re_velocel.tmp
scoreboard players operation @s re_velocel.vel.z = #_re_velocel.track.e3.deltaZ re_velocel.tmp

# 水平の合計絶対値 |x| + |z| (yawのデッドゾーン判定に使う)
scoreboard players set #_re_velocel.track.e3.totalXz re_velocel.tmp 0
execute if score @s re_velocel.vel.x matches 1.. run scoreboard players operation #_re_velocel.track.e3.totalXz re_velocel.tmp += @s re_velocel.vel.x
execute if score @s re_velocel.vel.x matches ..-1 run scoreboard players operation #_re_velocel.track.e3.totalXz re_velocel.tmp -= @s re_velocel.vel.x
execute if score @s re_velocel.vel.z matches 1.. run scoreboard players operation #_re_velocel.track.e3.totalXz re_velocel.tmp += @s re_velocel.vel.z
execute if score @s re_velocel.vel.z matches ..-1 run scoreboard players operation #_re_velocel.track.e3.totalXz re_velocel.tmp -= @s re_velocel.vel.z

# 合計絶対値 |x| + |y| + |z|
scoreboard players operation @s re_velocel.vel.total = #_re_velocel.track.e3.totalXz re_velocel.tmp
execute if score @s re_velocel.vel.y matches 1.. run scoreboard players operation @s re_velocel.vel.total += @s re_velocel.vel.y
execute if score @s re_velocel.vel.y matches ..-1 run scoreboard players operation @s re_velocel.vel.total -= @s re_velocel.vel.y

# デッドゾーンを超えていれば角度を更新する
execute if score @s re_velocel.vel.total >= #re_velocel.e3.ANGLE_DEADZONE re_velocel.const run function re_velocel:track/z/angle

# 水平速度
function re_velocel:track/z/length_xz

# ローカル変数のreset
# 毎tick実行が前提で、どの変数も使う前に必ず代入されるので、負荷を減らすために省略している
# scoreboard players reset #_re_velocel.track.e3.posX re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.posY re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.posZ re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.deltaX re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.deltaY re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.deltaZ re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.deltaTotal re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.heldTotal re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.totalXz re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e6.lengthSq re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e6.product re_velocel.tmp
# scoreboard players reset #_re_velocel.track.e3.quotient re_velocel.tmp
