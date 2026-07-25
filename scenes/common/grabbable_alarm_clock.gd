extends Grabbable



func _on_alarm_button_body_entered(body: Node2D) -> void:
	emit_signal("my_fuckin_ace_signal", body)

signal my_fuckin_ace_signal(body: Node2D)
