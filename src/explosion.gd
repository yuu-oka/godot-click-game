extends Sprite2D

const SPEED = 37 * 2 # 37パターンで0.5秒

var _pasttime = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_pasttime += delta
	
	frame = int(_pasttime * SPEED)
	if frame >= 38:
		queue_free()
	pass
