extends Node2D

class_name HangingFinger2D

@export var smash_timeout: float = 1
@export var finger_position: Vector2:
    set(value):
        finger_position = value
        if Engine.is_editor_hint():
            update_finger_location()
@export_range(-360, 360, 1, "degrees", "prefer_slider") var finger_rotation: int:
    set(value):
        finger_rotation = value
        if Engine.is_editor_hint():
            update_finger_location()
var is_smashed: bool = false
var is_hovered: bool = false
var finger_animations: AnimationPlayer 
var timer_container: Node2D
var smashed_timer: DigitalTimer2D


func update_finger_location() -> void:
    (%FingerArea as Node2D).position = finger_position
    (%FingerArea as Node2D).rotation_degrees = finger_rotation

func _ready() -> void:
    finger_animations = %FingerAnimations
    timer_container = %TimerContainer
    smashed_timer = %SmashedTimer
    timer_container.hide()
    update_finger_location()

signal smashed(finger: HangingFinger2D)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.is_pressed():
        if is_hovered and not is_smashed:
            smash()

func smash() -> void:
    finger_animations.play("hit")
    (%FingerHolding as Node2D).hide()
    timer_container.show()
    smashed_timer.timer.start(smash_timeout)
    is_smashed = true
    emit_signal("smashed", self)
    (%YelpSFX as AudioStreamPlayer).play()

func recover() -> void:
    timer_container.hide()    
    smashed_timer.timer.stop()
    is_smashed = false
    finger_animations.play_backwards("hit")
    (%FingerHolding as Node2D).show()
    if is_hovered:
        start_hover()
    

func start_hover() -> void:
    is_hovered = true
    if not is_smashed:
        finger_animations.play("shaking")

func end_hover() -> void:
    is_hovered = false
    if not is_smashed:
        finger_animations.stop()

func hand_smashed() -> void:
    timer_container.hide()    
    smashed_timer.timer.stop()
