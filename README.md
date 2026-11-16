# velocel

`velocel` は、Minecraftのデータパック開発において、エンティティの「絶対速度」「絶対加速度」、および「視点基準の移動速度・加速度（前後・左右）」と「運動方向の角度（Yaw/Pitch）」をリアルタイムで追跡・計算するための軽量・高パフォーマンスな数学ライブラリです。

Refate Datapack Style Guide (RDSG) に沿って書かれています。

## 使い方
追跡したいエンティティを実行者にして、毎tick関数を実行します
```
function re_velocel:track/
```
その後エンティティのスコアボードに値が入ります

負荷を抑えるため、機能を3つの関数に分けています。必要なものだけを、同じtickの `track/` の後に続けて実行してください。

| 関数 | 更新する値 |
| :--- | :--- |
| `re_velocel:track/` | 座標、速度（XYZ・合計・水平速度・角度）、加速度（XYZ） |
| `re_velocel:accel/` | 加速度の合計・角度 |
| `re_velocel:relative/` | 視点基準の前後・左右の速度と加速度 |

アンインストールするときは `function re_velocel:uninstall` を実行してからデータパックを外してください。

### 1. 座標データ
| オブジェクト名 | 倍率 | 説明 |
| :--- | :---: | :--- |
| `re_velocel.pos.x` | 1000倍 | エンティティの現在のワールドX座標 |
| `re_velocel.pos.y` | 1000倍 | エンティティの現在のワールドY座標 |
| `re_velocel.pos.z` | 1000倍 | エンティティの現在のワールドZ座標 |

### 2. 絶対運動データ（ワールド座標基準）
| オブジェクト名 | 倍率 | 説明 |
| :--- | :---: | :--- |
| `re_velocel.vel.x` | 1000倍 | ワールドX軸方向の速度（1tickあたりの移動量） |
| `re_velocel.vel.y` | 1000倍 | ワールドY軸方向の速度（1tickあたりの移動量） |
| `re_velocel.vel.z` | 1000倍 | ワールドZ軸方向の速度（1tickあたりの移動量） |
| `re_velocel.accel.x` | 1000倍 | ワールドX軸方向の加速度（1tickあたりの速度変化量） |
| `re_velocel.accel.y` | 1000倍 | ワールドY軸方向の加速度（1tickあたりの速度変化量） |
| `re_velocel.accel.z` | 1000倍 | ワールドZ軸方向の加速度（1tickあたりの速度変化量） |
| `re_velocel.vel.total` | 1000倍 | 3軸の速度の絶対値合計（マンハッタン距離） |
| `re_velocel.accel.total` | 1000倍 | 3軸の加速度の絶対値合計（マンハッタン距離）。`accel/` が必要 |
| `re_velocel.vel.length_xz` | 1000倍 | X・Z軸の速度から求めた `sqrt(x^2 + z^2)`（ニュートン法による近似値。水平方向の実移動速度） |

### 3. 相対運動データ（エンティティの視点基準）
*※ `re_velocel:relative/` の実行が必要です。*
| オブジェクト名 | 倍率 | 説明 |
| :--- | :---: | :--- |
| `re_velocel.vel.fb` | 1000倍 | 視点基準の速度（プラス：前方 / マイナス：後方） |
| `re_velocel.vel.rl` | 1000倍 | 視点基準の速度（プラス：右 / マイナス：左） |
| `re_velocel.accel.fb` | 1000倍 | 視点基準の加速度（プラス：前方加速 / マイナス：後方加速・ブレーキ） |
| `re_velocel.accel.rl` | 1000倍 | 視点基準の加速度（プラス：右加速 / マイナス：左加速） |

### 4. 運動方向の角度
*※合計絶対値がデッドゾーン（35）未満の時は、最後に動いていた方向の角度が維持されます。*
| オブジェクト名 | 倍率 | 説明 |
| :--- | :---: | :--- |
| `re_velocel.vel.angle_yaw` | **10倍** | 速度ベクトルが示す水平方向の角度（`-1800` 〜 `1800`） |
| `re_velocel.vel.angle_pitch` | **10倍** | 速度ベクトルが示す上下方向の角度（`-900` 〜 `900`） |
| `re_velocel.accel.angle_yaw` | **10倍** | 加速度ベクトルが示す水平方向の角度。`accel/` が必要 |
| `re_velocel.accel.angle_pitch` | **10倍** | 加速度ベクトルが示す上下方向の角度。`accel/` が必要 |

デッドゾーンは `load.mcfunction` の `#re_velocel.e3.ANGLE_DEADZONE` で変更できます。

### 内部で使用するオブジェクト
`re_velocel.tmp`（ローカル変数）、`re_velocel.const`（定数）、`re_velocel.stall`（パケット補間の状態）は内部用です。書き換えないでください。ストレージ `re_velocel:` の `vector` も内部用です。

毎tick実行が前提のため、負荷を減らす目的でローカル変数の reset は行っていません（どの変数も使う前に必ず代入されます）。

## パケットの補間
プレイヤーの移動パケットの受信タイミングはサーバーのtickと同期していないため、動いているのに座標が全く変わらないtickが生まれることがあります。velocelはこれを次のように補間します。

1. 動いていたのに3軸とも座標が全く変わらなかったtickは、パケットが届かなかっただけとみなし、**全ての値を前のtickのまま保持**します。
2. その次のtickで、届かなかった分もまとめて動いていた場合（移動量が保持中の速度の1.5倍以上）は、2tick分の移動量とみなして**半分にした値**を速度にします。
3. 2tick連続で座標が変わらなかった場合は、本当に止まったものとして速度を0にします。

このため、壁への衝突などで**完全に**急停止した場合は、速度が0になるのが1tick遅れます。

## ⚠️ 注意事項
**固定UUIDの使用** : 角度計算用のマーカーエンティティに固定のUUID（7bd848b4-0c9f-4328-912b-9a2b7244b2de）を使用しています。万が一消えてしまっても計算前に再召喚されます。マーカーはオーバーワールドの 0 0 のチャンクに置くため、このチャンクをforceloadします。

**テレポート（瞬間移動）時の異常値** : tp コマンド等でエンティティを長距離テレポートさせた場合、1tick前との座標差分が巨大になり、速度や加速度が異常な数値として算出されます。初めて `track/` を実行したtickも同様です。テレポートを行う際は、直後の1tickは計算結果を利用しないなどの対策を推奨します。対策をする場合は速度合計が一定以上の場合などで条件付けするのがおすすめです。

**誤差** : 角度データは移動量がごくわずかな場合1度から2度程度の誤差が生じます。気になる場合はデッドゾーンを調整してください

## 旧バージョンからの移行
オブジェクト名が `re_velocel_velX` → `re_velocel.vel.x` のように変わりました。また、加速度の合計・角度と視点基準の前後・左右は `track/` だけでは更新されなくなったので、使っている場合は `accel/` や `relative/` を追加で実行してください。`function re_velocel:uninstall` は旧バージョンのオブジェクトとマーカーも削除するので、一度実行してから `/reload` してください。

| 旧 | 新 |
| :--- | :--- |
| `re_velocel_posX` / `Y` / `Z` | `re_velocel.pos.x` / `y` / `z` |
| `re_velocel_velX` / `Y` / `Z` | `re_velocel.vel.x` / `y` / `z` |
| `re_velocel_accelX` / `Y` / `Z` | `re_velocel.accel.x` / `y` / `z` |
| `re_velocel_velFB` / `velRL` | `re_velocel.vel.fb` / `re_velocel.vel.rl` |
| `re_velocel_accelFB` / `accelRL` | `re_velocel.accel.fb` / `re_velocel.accel.rl` |
| `re_velocel_velTotal` / `accelTotal` | `re_velocel.vel.total` / `re_velocel.accel.total` |
| `re_velocel_velLengthXZ` | `re_velocel.vel.length_xz` |
| `re_velocel_velAngleYaw` / `velAnglePitch` | `re_velocel.vel.angle_yaw` / `re_velocel.vel.angle_pitch` |
| `re_velocel_accelAngleYaw` / `accelAnglePitch` | `re_velocel.accel.angle_yaw` / `re_velocel.accel.angle_pitch` |
