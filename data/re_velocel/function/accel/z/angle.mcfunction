#> re_velocel:accel/z/angle
# @within re_velocel:accel/
# 実行者の加速度ベクトルの向きを角度にする
# 速度用の re_velocel:track/z/angle と同じ処理なので、直すときは両方直すこと
# (マクロで共通化すると毎tickキャッシュ参照が走るので、あえて2つ書いている)

# マーカーが消えてしまった場合に備える
execute unless entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de run function re_velocel:track/z/summon_marker

# マーカーをベクトルの先に置き、原点から見た向きをマーカーの向きとして読み取る
# (エンティティへの書き込みは重いので、ストレージで組み立ててから1回で書き込む)
execute store result storage re_velocel: vector[0] double 0.001 run scoreboard players get @s re_velocel.accel.x
execute store result storage re_velocel: vector[1] double 0.001 run scoreboard players get @s re_velocel.accel.y
execute store result storage re_velocel: vector[2] double 0.001 run scoreboard players get @s re_velocel.accel.z
data modify entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Pos set from storage re_velocel: vector
execute in overworld positioned 0.0 0.0 0.0 facing entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de feet run rotate 7bd848b4-0c9f-4328-912b-9a2b7244b2de ~ ~

# yawは水平成分がデッドゾーンを超えているときだけ更新する (真上・真下への加速で向きが暴れないように)
execute if score #_re_velocel.accel.e3.totalXz re_velocel.tmp >= #re_velocel.e3.ANGLE_DEADZONE re_velocel.const store result score @s re_velocel.accel.angle_yaw run data get entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Rotation[0] 10
execute store result score @s re_velocel.accel.angle_pitch run data get entity 7bd848b4-0c9f-4328-912b-9a2b7244b2de Rotation[1] 10

# forceloadしているチャンクの外に出たままにならないよう原点へ戻す
execute in overworld run tp 7bd848b4-0c9f-4328-912b-9a2b7244b2de 0.0 0.0 0.0
