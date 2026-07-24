extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_go_to_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _go_to_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/minigames/evil_usb/minigame_usb.tscn")
