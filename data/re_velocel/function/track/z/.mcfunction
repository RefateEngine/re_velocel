data modify storage re_velocel: calc set value {}

# 座標をprevに移す
scoreboard players operation #re_velocel_prevPosX re_velocel = @s re_velocel_posX
scoreboard players operation #re_velocel_prevPosY re_velocel = @s re_velocel_posY
scoreboard players operation #re_velocel_prevPosZ re_velocel = @s re_velocel_posZ

# 座標を取得 (1000倍)
execute at @s summon marker run function re_velocel:track/z/get_current_coords
execute store result score @s re_velocel_posX run data get storage re_velocel: calc.currentCoords[0] 1000
execute store result score @s re_velocel_posY run data get storage re_velocel: calc.currentCoords[1] 1000
execute store result score @s re_velocel_posZ run data get storage re_velocel: calc.currentCoords[2] 1000

# 速度をprevに移す
scoreboard players operation #re_velocel_prevVelX re_velocel = @s re_velocel_velX
scoreboard players operation #re_velocel_prevVelY re_velocel = @s re_velocel_velY
scoreboard players operation #re_velocel_prevVelZ re_velocel = @s re_velocel_velZ

# 速度を計算 X,Y,Z
scoreboard players operation @s re_velocel_velX = @s re_velocel_posX
scoreboard players operation @s re_velocel_velX -= #re_velocel_prevPosX re_velocel

scoreboard players operation @s re_velocel_velY = @s re_velocel_posY
scoreboard players operation @s re_velocel_velY -= #re_velocel_prevPosY re_velocel

scoreboard players operation @s re_velocel_velZ = @s re_velocel_posZ
scoreboard players operation @s re_velocel_velZ -= #re_velocel_prevPosZ re_velocel

# 加速度を計算 X,Y,Z
scoreboard players operation @s re_velocel_accelX = @s re_velocel_velX
scoreboard players operation @s re_velocel_accelX -= #re_velocel_prevVelX re_velocel

scoreboard players operation @s re_velocel_accelY = @s re_velocel_velY
scoreboard players operation @s re_velocel_accelY -= #re_velocel_prevVelY re_velocel

scoreboard players operation @s re_velocel_accelZ = @s re_velocel_velZ
scoreboard players operation @s re_velocel_accelZ -= #re_velocel_prevVelZ re_velocel



# 視点基準の前方方向の単位ベクトルを取得
execute at @s rotated ~ 0 positioned 0.0 0.0 0.0 positioned ^ ^ ^1 summon marker run function re_velocel:track/z/get_front_coords

# 視点基準の前方方向の速度を計算する X,Z
execute store result score #re_velocel_matrixX re_velocel run data get storage re_velocel: calc.frontVector[0] 1000
scoreboard players operation #re_velocel_matrixX re_velocel *= @s re_velocel_velX
scoreboard players operation #re_velocel_matrixX re_velocel /= #re_velocel_scale re_velocel

execute store result score #re_velocel_matrixZ re_velocel run data get storage re_velocel: calc.frontVector[2] 1000
scoreboard players operation #re_velocel_matrixZ re_velocel *= @s re_velocel_velZ
scoreboard players operation #re_velocel_matrixZ re_velocel /= #re_velocel_scale re_velocel

scoreboard players operation @s re_velocel_velFB = #re_velocel_matrixX re_velocel
scoreboard players operation @s re_velocel_velFB += #re_velocel_matrixZ re_velocel

# 視点基準の前方方向の加速度を計算する X,Z
execute store result score #re_velocel_matrixX re_velocel run data get storage re_velocel: calc.frontVector[0] 1000
scoreboard players operation #re_velocel_matrixX re_velocel *= @s re_velocel_accelX
scoreboard players operation #re_velocel_matrixX re_velocel /= #re_velocel_scale re_velocel

execute store result score #re_velocel_matrixZ re_velocel run data get storage re_velocel: calc.frontVector[2] 1000
scoreboard players operation #re_velocel_matrixZ re_velocel *= @s re_velocel_accelZ
scoreboard players operation #re_velocel_matrixZ re_velocel /= #re_velocel_scale re_velocel

scoreboard players operation @s re_velocel_accelFB = #re_velocel_matrixX re_velocel
scoreboard players operation @s re_velocel_accelFB += #re_velocel_matrixZ re_velocel



# 視点基準の右方向の単位ベクトルを取得
execute at @s rotated ~90 0 positioned 0.0 0.0 0.0 positioned ^ ^ ^1 summon marker run function re_velocel:track/z/get_right_coords

# 視点基準の右方向の速度を計算する X,Z
execute store result score #re_velocel_matrixX re_velocel run data get storage re_velocel: calc.rightVector[0] 1000
scoreboard players operation #re_velocel_matrixX re_velocel *= @s re_velocel_velX
scoreboard players operation #re_velocel_matrixX re_velocel /= #re_velocel_scale re_velocel

scoreboard players operation #re_velocel_matrixZ re_velocel *= @s re_velocel_velZ
scoreboard players operation #re_velocel_matrixZ re_velocel /= #re_velocel_scale re_velocel

scoreboard players operation @s re_velocel_velRL = #re_velocel_matrixX re_velocel
scoreboard players operation @s re_velocel_velRL += #re_velocel_matrixZ re_velocel

# 視点基準の右方向の加速度を計算する X,Z
execute store result score #re_velocel_matrixZ re_velocel run data get storage re_velocel: calc.rightVector[2] 1000
scoreboard players operation #re_velocel_matrixX re_velocel *= @s re_velocel_accelX
scoreboard players operation #re_velocel_matrixX re_velocel /= #re_velocel_scale re_velocel

scoreboard players operation #re_velocel_matrixZ re_velocel *= @s re_velocel_accelZ
scoreboard players operation #re_velocel_matrixZ re_velocel /= #re_velocel_scale re_velocel

scoreboard players operation @s re_velocel_accelRL = #re_velocel_matrixX re_velocel
scoreboard players operation @s re_velocel_accelRL += #re_velocel_matrixZ re_velocel

# 速度が0以上の場合最も力の強い方向を計算する
scoreboard players operation #re_velocel_deadzoneX re_velocel = @s re_velocel_velX
execute if score #re_velocel_deadzoneX re_velocel matches ..-1 run scoreboard players operation #re_velocel_deadzoneX re_velocel *= #re_velocel_negative re_velocel

scoreboard players operation #re_velocel_deadzoneZ re_velocel = @s re_velocel_velZ
execute if score #re_velocel_deadzoneZ re_velocel matches ..-1 run scoreboard players operation #re_velocel_deadzoneZ re_velocel *= #re_velocel_negative re_velocel

scoreboard players operation #re_velocel_deadzoneX re_velocel += #re_velocel_deadzoneZ re_velocel

execute if score #re_velocel_deadzoneX re_velocel matches 50.. run function re_velocel:track/z/calc_vel_angle

# 加速度が0以上の場合最も力の強い方向を計算する
scoreboard players operation #re_velocel_deadzoneX re_velocel = @s re_velocel_accelX
execute if score #re_velocel_deadzoneX re_velocel matches ..-1 run scoreboard players operation #re_velocel_deadzoneX re_velocel *= #re_velocel_negative re_velocel

scoreboard players operation #re_velocel_deadzoneZ re_velocel = @s re_velocel_accelZ
execute if score #re_velocel_deadzoneZ re_velocel matches ..-1 run scoreboard players operation #re_velocel_deadzoneZ re_velocel *= #re_velocel_negative re_velocel

scoreboard players operation #re_velocel_deadzoneX re_velocel += #re_velocel_deadzoneZ re_velocel

execute if score #re_velocel_deadzoneX re_velocel matches 50.. run function re_velocel:track/z/calc_accel_angle