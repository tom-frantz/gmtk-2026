extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    position = get_viewport().get_mouse_position()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.is_pressed():
        if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
            (%HammerHitSFX as AudioStreamPlayer).play()
