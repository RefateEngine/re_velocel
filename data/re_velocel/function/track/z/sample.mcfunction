#> re_velocel:track/z/sample
# @within re_velocel:track/
# 計測対象の位置に召喚したマーカーとして実行し、現在座標を読み取る
# (プレイヤーのNBTを直接読むと重いので、マーカーの座標として読み取る)

execute store result score #_re_velocel.track.e3.posX re_velocel.tmp run data get entity @s Pos[0] 1000
execute store result score #_re_velocel.track.e3.posY re_velocel.tmp run data get entity @s Pos[1] 1000
execute store result score #_re_velocel.track.e3.posZ re_velocel.tmp run data get entity @s Pos[2] 1000

kill @s
