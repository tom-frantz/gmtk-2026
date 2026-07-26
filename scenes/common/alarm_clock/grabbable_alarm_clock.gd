extends Grabbable


func _on_alarm_button_body_entered(body: Node2D) -> void:
	if collision_layer == 1:
		emit_signal("my_fuckin_ace_signal", body)

signal my_fuckin_ace_signal(body: Node2D)

func _ready() -> void:
    was_pressed = false

func _on_alarm_button_body_entered(body: Node2D) -> void:
    if collision_layer == 1 and not was_pressed:
        was_pressed = true
        emit_signal("my_fuckin_ace_signal", body)

