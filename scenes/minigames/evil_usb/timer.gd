extends Timer

var lost: bool = false

func _ready() -> void:
	self.timeout.connect(_handle_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lost && Input.is_action_just_pressed("left_click"):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _handle_timeout() -> void:
	lost = true
	self.paused = true
	var lose_banner: Label = self.get_child(0)
	lose_banner.visible = true
	get_tree().paused = true
