#> re_velocel:track/z/catch_up
# @within re_velocel:track/
# 値を保持した次のtickに実行する
# 届かなかった分もまとめて動いた場合、移動量は2tick分になっているので半分にする
# (クライアントが遅れただけで1tick分しか動いていない場合はそのまま使う)

# 移動量の合計絶対値
scoreboard players set #_re_velocel.track.e3.deltaTotal re_velocel.tmp 0
execute if score #_re_velocel.track.e3.deltaX re_velocel.tmp matches 1.. run scoreboard players operation #_re_velocel.track.e3.deltaTotal re_velocel.tmp += #_re_velocel.track.e3.deltaX re_velocel.tmp
execute if score #_re_velocel.track.e3.deltaX re_velocel.tmp matches ..-1 run scoreboard players operation #_re_velocel.track.e3.deltaTotal re_velocel.tmp -= #_re_velocel.track.e3.deltaX re_velocel.tmp
execute if score #_re_velocel.track.e3.deltaY re_velocel.tmp matches 1.. run scoreboard players operation #_re_velocel.track.e3.deltaTotal re_velocel.tmp += #_re_velocel.track.e3.deltaY re_velocel.tmp
execute if score #_re_velocel.track.e3.deltaY re_velocel.tmp matches ..-1 run scoreboard players operation #_re_velocel.track.e3.deltaTotal re_velocel.tmp -= #_re_velocel.track.e3.deltaY re_velocel.tmp
execute if score #_re_velocel.track.e3.deltaZ re_velocel.tmp matches 1.. run scoreboard players operation #_re_velocel.track.e3.deltaTotal re_velocel.tmp += #_re_velocel.track.e3.deltaZ re_velocel.tmp
execute if score #_re_velocel.track.e3.deltaZ re_velocel.tmp matches ..-1 run scoreboard players operation #_re_velocel.track.e3.deltaTotal re_velocel.tmp -= #_re_velocel.track.e3.deltaZ re_velocel.tmp

# 保持している速度の1.5倍未満なら1tick分の移動とみなす (deltaTotal * 2 < heldTotal * 3)
scoreboard players operation #_re_velocel.track.e3.deltaTotal re_velocel.tmp *= #re_velocel.2 re_velocel.const
scoreboard players operation #_re_velocel.track.e3.heldTotal re_velocel.tmp = @s re_velocel.vel.total
scoreboard players operation #_re_velocel.track.e3.heldTotal re_velocel.tmp *= #re_velocel.3 re_velocel.const
execute if score #_re_velocel.track.e3.deltaTotal re_velocel.tmp < #_re_velocel.track.e3.heldTotal re_velocel.tmp run return fail

# 2tick分を1tickあたりに直す
scoreboard players operation #_re_velocel.track.e3.deltaX re_velocel.tmp /= #re_velocel.2 re_velocel.const
scoreboard players operation #_re_velocel.track.e3.deltaY re_velocel.tmp /= #re_velocel.2 re_velocel.const
scoreboard players operation #_re_velocel.track.e3.deltaZ re_velocel.tmp /= #re_velocel.2 re_velocel.const
