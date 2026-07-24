extends Timer

func _ready() -> void:
	self.timeout.connect(_handle_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _handle_timeout() -> void:
	var lose_banner: Label = self.get_child(0)
	lose_banner.visible = true
