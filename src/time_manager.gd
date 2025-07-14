extends Node

const GAME_OVER_TIME = 10.0
var _past_time: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_past_time += delta
	pass

func get_limit_time() -> int:
	return int(GAME_OVER_TIME - _past_time)

func is_game_over() -> bool:
	# ゲームオーバーの判定
	return _past_time >= GAME_OVER_TIME