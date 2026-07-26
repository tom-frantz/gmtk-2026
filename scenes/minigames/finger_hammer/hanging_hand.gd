extends Node2D

class_name HangingHand2D

@export var is_right: bool = false
@export var finger_timeouts: Array[float] = [2,2,2, 2]

var is_hand_smashed: bool = false
var fingers: Array[HangingFinger2D] 
var arm_animation: AnimationPlayer
var arm: MeshInstance2D

signal smashed

func _ready() -> void:
    arm_animation = %ArmAnimation
    arm = %Arm
    fingers = [%Index, %Middle, %Ring, %Pinky]
    finger_timeouts.shuffle()
    var f_x: Array[float]
    for f: HangingFinger2D in fingers:
        f.connect("smashed", finger_smashed)
        f.smash_timeout = finger_timeouts.pop_front()
        f_x.append(f.position.x)
    
    if is_right:
        arm.scale.x *= -1
        var num_f: float = fingers.size()
        for idx: int in range(num_f):
            fingers[idx].position.x = f_x[num_f - idx - 1]
            var fa: Area2D = fingers[idx].get_node("FingerArea")
            fa.rotation = -fa.rotation
    
    arm_animation.play("swaying")
            
func finger_smashed(_finger: HangingFinger2D) -> void:
    for f: HangingFinger2D in fingers:
        if not f.is_smashed:
            return

    # hand smashed
    for f: HangingFinger2D in fingers:
        f.hand_smashed()
    (%HandSmashSFX as AudioStreamPlayer).play()

func hand_smashed() -> void:
    is_hand_smashed = true
    arm_animation.play("fall")
    emit_signal("smashed")


func _on_arm_animation_animation_finished(anim_name: StringName) -> void:
    if anim_name == "fall":
        queue_free()