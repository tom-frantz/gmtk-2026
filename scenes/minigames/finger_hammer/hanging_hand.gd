extends Node2D

@export var is_right: bool = false
@export var finger_timeouts: Array[float] = [2,2,2, 2]

var fingers: Array[HangingFinger2D] 

func _ready() -> void:
    fingers = [%Index, %Middle, %Ring, %Pinky]
    finger_timeouts.shuffle()
    var f_x: Array[float]
    for f in fingers:
        f.connect("smashed", finger_smashed)
        f.smash_timeout = finger_timeouts.pop_front()
        f_x.append(f.position.x)
    
    if is_right:
        var num_f: float = fingers.size()
        for idx in range(num_f):
            fingers[idx].position.x = f_x[num_f - idx - 1]
            var fa: Area2D = fingers[idx].get_node("FingerArea")
            fa.rotation = -fa.rotation
            



func finger_smashed(_finger: HangingFinger2D) -> void:
    for f in fingers:
        if not f.is_smashed:
            return

    # hand smashed
    for f in fingers:
        f.hand_smashed()
    (%HandSmashSFX as AudioStreamPlayer).play()

func hand_smashed() -> void:
    print("Hand Smashed")
    self.queue_free()
