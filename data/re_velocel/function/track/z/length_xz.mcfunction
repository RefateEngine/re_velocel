#> re_velocel:track/z/length_xz
# @within re_velocel:track/
# 実行者の水平速度 sqrt(x^2 + z^2) をニュートン法で求める

# x^2 + z^2
scoreboard players operation #_re_velocel.track.e6.lengthSq re_velocel.tmp = @s re_velocel.vel.x
scoreboard players operation #_re_velocel.track.e6.lengthSq re_velocel.tmp *= @s re_velocel.vel.x
scoreboard players operation #_re_velocel.track.e6.product re_velocel.tmp = @s re_velocel.vel.z
scoreboard players operation #_re_velocel.track.e6.product re_velocel.tmp *= @s re_velocel.vel.z
scoreboard players operation #_re_velocel.track.e6.lengthSq re_velocel.tmp += #_re_velocel.track.e6.product re_velocel.tmp

# 初期値は |x| と |z| の大きい方
scoreboard players operation @s re_velocel.vel.length_xz = @s re_velocel.vel.x
execute if score @s re_velocel.vel.length_xz matches ..-1 run scoreboard players operation @s re_velocel.vel.length_xz *= #re_velocel.-1 re_velocel.const
scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp = @s re_velocel.vel.z
execute if score #_re_velocel.track.e3.quotient re_velocel.tmp matches ..-1 run scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp *= #re_velocel.-1 re_velocel.const
scoreboard players operation @s re_velocel.vel.length_xz > #_re_velocel.track.e3.quotient re_velocel.tmp

# 水平に動いていなければ0で確定 (0除算になるので反復しない)
execute if score @s re_velocel.vel.length_xz matches 0 run return 0

# ニュートン法: length = (length + lengthSq / length) / 2
# 初期値は真値の約0.7倍以上なので3回で収束する
scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp = #_re_velocel.track.e6.lengthSq re_velocel.tmp
scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp /= @s re_velocel.vel.length_xz
scoreboard players operation @s re_velocel.vel.length_xz += #_re_velocel.track.e3.quotient re_velocel.tmp
scoreboard players operation @s re_velocel.vel.length_xz /= #re_velocel.2 re_velocel.const

scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp = #_re_velocel.track.e6.lengthSq re_velocel.tmp
scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp /= @s re_velocel.vel.length_xz
scoreboard players operation @s re_velocel.vel.length_xz += #_re_velocel.track.e3.quotient re_velocel.tmp
scoreboard players operation @s re_velocel.vel.length_xz /= #re_velocel.2 re_velocel.const

scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp = #_re_velocel.track.e6.lengthSq re_velocel.tmp
scoreboard players operation #_re_velocel.track.e3.quotient re_velocel.tmp /= @s re_velocel.vel.length_xz
scoreboard players operation @s re_velocel.vel.length_xz += #_re_velocel.track.e3.quotient re_velocel.tmp
scoreboard players operation @s re_velocel.vel.length_xz /= #re_velocel.2 re_velocel.const
