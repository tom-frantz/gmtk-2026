extends Node2D

func _ready() -> void:
	(%Sprite as Sprite2D).hide()

func _on_timer_timeout() -> void:
	(%Sprite as Sprite2D).show()
	(%Animator as AnimationPlayer).play("move_up")
