extends Area2D

class_name HangingFinger2D

@export var smash_timeout: float = 1
var is_smashed: bool = false
var is_hovered: bool = false

signal smashed(finger: HangingFinger2D)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if is_hovered:
			smash()

func smash() -> void:
	%FingerAnimations.play("hit")
	%SmashedTimer.start(smash_timeout)
	is_smashed = true
	is_hovered = false
	emit_signal("smashed", self)

func recover() -> void:
	%SmashedTimer.stop()
	is_smashed = false
	%FingerAnimations.play_backwards("hit")
	

func start_hover() -> void:
	if not is_smashed:
		is_hovered = true
		%FingerAnimations.play("shaking")

func end_hover() -> void:
	if not is_smashed:
		is_hovered = false
		%FingerAnimations.stop()