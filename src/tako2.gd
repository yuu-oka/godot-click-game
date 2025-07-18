extends Tako
class_name Tako2

@onready var _maker = $Marker
@onready var _cursor = $Cursor

var _target_rotate:float = 0.0
var _rotate: float = 0.0

func _ready() -> void:
	# 親クラスの _ready を呼び出す
	super._ready()
	_target_rotate = randf_range(90, 270)
	_maker.rotation = _target_rotate

	pass # Replace with function body.

func _process(_delta):
	super(_delta)

	_rotate = _delta * 5.0
	if _rotate >= 360.0:
		_rotate = 0.0

	_cursor.rotate(_rotate)

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
			if _target_rotate + 20 > _rotate and _target_rotate - 20 < _rotate:
				ScoreManager.add_score(10)
			else:
				ScoreManager.add_score(1)

			queue_free()
	pass # Replace with function body.
