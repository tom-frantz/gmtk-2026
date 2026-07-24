extends Node2D

class_name HangingFinger2D

@export var smash_timeout: float = 1
var is_smashed: bool = false
var is_hovered: bool = false
var finger_animations: AnimationPlayer 
var smashed_timer: Node2D

func _ready() -> void:
    finger_animations = %FingerAnimations
    smashed_timer = %SmashedTimer

signal smashed(finger: HangingFinger2D)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.is_pressed():
        if is_hovered:
            smash()

func smash() -> void:
    finger_animations.play("hit")
    smashed_timer.show()
    (smashed_timer.get_node("Timer") as Timer).start(smash_timeout)
    is_smashed = true
    is_hovered = false
    emit_signal("smashed", self)
    (%YelpSFX as AudioStreamPlayer).play()

func recover() -> void:
    smashed_timer.hide()    
    (smashed_timer.get_node("Timer") as Timer).stop()
    is_smashed = false
    finger_animations.play_backwards("hit")
    

func start_hover() -> void:
    if not is_smashed:
        is_hovered = true
        finger_animations.play("shaking")

func end_hover() -> void:
    if not is_smashed:
        is_hovered = false
        finger_animations.stop()

func hand_smashed() -> void:
    smashed_timer.hide()    
    (smashed_timer.get_node("Timer") as Timer).stop()
