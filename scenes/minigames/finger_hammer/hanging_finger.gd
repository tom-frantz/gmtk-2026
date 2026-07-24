extends Area2D

class_name HangingFinger2D

@export var loose_time: float = 10
var is_smashed: bool = false
var is_hovered: bool = false

signal smashed(finger: HangingFinger2D)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		smash()

func smash() -> void:
	if is_hovered:
		%FingerAnimations.play("hit")
		is_smashed = true
		is_hovered = false
		emit_signal("smashed", self)

func start_hover() -> void:
	if not is_smashed:
		is_hovered = true
		%FingerAnimations.play("shaking")

func end_hover() -> void:
	if not is_smashed:
		is_hovered = false
		%FingerAnimations.stop()