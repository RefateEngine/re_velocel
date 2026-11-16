#> re_velocel:relative/z/sample
# @within re_velocel:relative/
# 原点から視点前方へ1ブロックの位置に召喚したマーカーとして実行し、前方の単位ベクトルを読み取る

execute store result score #_re_velocel.relative.e3.frontX re_velocel.tmp run data get entity @s Pos[0] 1000
execute store result score #_re_velocel.relative.e3.frontZ re_velocel.tmp run data get entity @s Pos[2] 1000

kill @s
