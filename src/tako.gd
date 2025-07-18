extends Area2D
class_name Tako

const EXPLOSION_OBJ = preload("res://src/explosion.tscn")

## タコの移動速度
const MOVE_SPEED: float = 200.0

## 画面サイズ
var _screen = Rect2()

## 移動量
var _velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 画面サイズを取得
	_screen = get_viewport_rect()

	# 移動速度をランダムで決定
	_velocity.x = randf_range(-1, 1)
	_velocity.y = randf_range(-1, 1)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 移動処理
	position += _velocity * MOVE_SPEED * delta

	# 画面端での跳ね返り判定
	if position.x < 0:
		position.x = 0
		_velocity.x *= -1

	if position.y < 0:
		position.y = 0
		_velocity.y *= -1

	if position.x > _screen.size.x:
		position.x = _screen.size.x
		_velocity.x *= -1

	if position.y > _screen.size.y:
		position.y = _screen.size.y
		_velocity.y *= -1
	pass


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if TimeManager.is_game_over():
		return

	if event is InputEventMouseButton:
		# マウスの入力があった場合の処理
		if event.is_pressed():
			# 爆発エフェクトを生成
			var explosion = EXPLOSION_OBJ.instantiate()
			explosion.position = position
			get_parent().add_child(explosion)

			# scoreを加算
			ScoreManager.add_score(1)

			queue_free()
	pass # Replace with function body.
