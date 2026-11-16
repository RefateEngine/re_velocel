#> re_velocel:relative/
# 実行者の視点基準(水平)の前後・左右の速度と加速度を計算する
# 同じtickの re_velocel:track/ の後に実行する
#
# 更新する値:
#   re_velocel.vel.fb / rl
#   re_velocel.accel.fb / rl

# 視点前方(水平)の単位ベクトルを取得する。右方向は (-frontZ, frontX) なので前方だけ取れば足りる
execute at @s rotated ~ 0 positioned 0.0 0.0 0.0 positioned ^ ^ ^1 summon marker run function re_velocel:relative/z/sample

# 前後速度 = x * frontX + z * frontZ
scoreboard players operation @s re_velocel.vel.fb = @s re_velocel.vel.x
scoreboard players operation @s re_velocel.vel.fb *= #_re_velocel.relative.e3.frontX re_velocel.tmp
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp = @s re_velocel.vel.z
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp *= #_re_velocel.relative.e3.frontZ re_velocel.tmp
scoreboard players operation @s re_velocel.vel.fb += #_re_velocel.relative.e6.product re_velocel.tmp
scoreboard players operation @s re_velocel.vel.fb /= #re_velocel.1000 re_velocel.const

# 左右速度(右が正) = z * frontX - x * frontZ
scoreboard players operation @s re_velocel.vel.rl = @s re_velocel.vel.z
scoreboard players operation @s re_velocel.vel.rl *= #_re_velocel.relative.e3.frontX re_velocel.tmp
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp = @s re_velocel.vel.x
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp *= #_re_velocel.relative.e3.frontZ re_velocel.tmp
scoreboard players operation @s re_velocel.vel.rl -= #_re_velocel.relative.e6.product re_velocel.tmp
scoreboard players operation @s re_velocel.vel.rl /= #re_velocel.1000 re_velocel.const

# 前後加速度 = x * frontX + z * frontZ
scoreboard players operation @s re_velocel.accel.fb = @s re_velocel.accel.x
scoreboard players operation @s re_velocel.accel.fb *= #_re_velocel.relative.e3.frontX re_velocel.tmp
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp = @s re_velocel.accel.z
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp *= #_re_velocel.relative.e3.frontZ re_velocel.tmp
scoreboard players operation @s re_velocel.accel.fb += #_re_velocel.relative.e6.product re_velocel.tmp
scoreboard players operation @s re_velocel.accel.fb /= #re_velocel.1000 re_velocel.const

# 左右加速度(右が正) = z * frontX - x * frontZ
scoreboard players operation @s re_velocel.accel.rl = @s re_velocel.accel.z
scoreboard players operation @s re_velocel.accel.rl *= #_re_velocel.relative.e3.frontX re_velocel.tmp
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp = @s re_velocel.accel.x
scoreboard players operation #_re_velocel.relative.e6.product re_velocel.tmp *= #_re_velocel.relative.e3.frontZ re_velocel.tmp
scoreboard players operation @s re_velocel.accel.rl -= #_re_velocel.relative.e6.product re_velocel.tmp
scoreboard players operation @s re_velocel.accel.rl /= #re_velocel.1000 re_velocel.const

# ローカル変数のreset
# 毎tick実行が前提で、どの変数も使う前に必ず代入されるので、負荷を減らすために省略している
# scoreboard players reset #_re_velocel.relative.e3.frontX re_velocel.tmp
# scoreboard players reset #_re_velocel.relative.e3.frontZ re_velocel.tmp
# scoreboard players reset #_re_velocel.relative.e6.product re_velocel.tmp
