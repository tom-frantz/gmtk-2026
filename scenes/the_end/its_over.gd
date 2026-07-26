extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    self.play("boom")
    %boom_audio.play()
    animation_finished.connect(_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _animation_finished() -> void:
    var the_end_label: Label = %game_over_label
    the_end_label.visible = true
    get_tree().change_scene_to_file("res://scenes/end_credits.tscn")
