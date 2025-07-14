extends Node2D

@onready var _label = $Label
@onready var _score = $Score
@onready var _limit_time = $LimitTime

const TAKO_OBJ = preload("res://src/tako.tscn")
const WAIT_TIME = 0.5

var _pasttime = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if TimeManager.is_game_over():
		_label.visible = true
		return

	_pasttime += _delta

	# たこやきの生存数をカウント
	var cnt = 0
	for child in get_children():
		if "Tako" in child.name:
			cnt += 1

	if _pasttime >= WAIT_TIME:
		_pasttime = 0.0
		# タコを生成
		var tako = TAKO_OBJ.instantiate()
		tako.name = "Tako" + str(cnt)
		tako.position = Vector2(randf_range(0, get_viewport_rect().size.x), randf_range(0, get_viewport_rect().size.y))
		add_child(tako)

	# スコアを更新
	_score.text = str(ScoreManager.score)

	# ゲームオーバーの時間を表示
	if !TimeManager.is_game_over():
		_limit_time.text = "残り時間: " + str(TimeManager.get_limit_time()) + "秒"
	pass
