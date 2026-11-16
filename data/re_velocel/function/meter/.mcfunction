#> re_velocel:meter/
# 実行者の計測値をアクションバーに表示する (デバッグ用)
# 加速度の合計・角度は re_velocel:accel/ 、前後・左右は re_velocel:relative/ を実行していないと更新されない

title @s actionbar [\
"速度XYZ:[",{score:{name:"@s",objective:"re_velocel.vel.x"}},",",{score:{name:"@s",objective:"re_velocel.vel.y"}},",",{score:{name:"@s",objective:"re_velocel.vel.z"}},"] ",\
"加速度XYZ:[",{score:{name:"@s",objective:"re_velocel.accel.x"}},",",{score:{name:"@s",objective:"re_velocel.accel.y"}},",",{score:{name:"@s",objective:"re_velocel.accel.z"}},"] ",\
"前後速度:",{score:{name:"@s",objective:"re_velocel.vel.fb"}}," 左右速度:",{score:{name:"@s",objective:"re_velocel.vel.rl"}},\
" 前後加速度:",{score:{name:"@s",objective:"re_velocel.accel.fb"}}," 左右加速度:",{score:{name:"@s",objective:"re_velocel.accel.rl"}},\
" 速度角度:[",{score:{name:"@s",objective:"re_velocel.vel.angle_yaw"}},",",{score:{name:"@s",objective:"re_velocel.vel.angle_pitch"}},"]",\
" 加速度角度:[",{score:{name:"@s",objective:"re_velocel.accel.angle_yaw"}},",",{score:{name:"@s",objective:"re_velocel.accel.angle_pitch"}},"]",\
" 速度合計:",{score:{name:"@s",objective:"re_velocel.vel.total"}}," 加速度合計:",{score:{name:"@s",objective:"re_velocel.accel.total"}},\
" 水平速度:",{score:{name:"@s",objective:"re_velocel.vel.length_xz"}}\
]
