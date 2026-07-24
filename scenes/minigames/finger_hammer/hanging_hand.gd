extends Node2D

var fingers: Array[HangingFinger2D] 

func _ready() -> void:
    fingers = [%Index, %Middle, %Ring, %Pinky]
    for f in fingers:
        f.connect("smashed", finger_smashed)


func finger_smashed(_finger: HangingFinger2D):
    for f in fingers:
        if not f.is_smashed:
            return
    
    print("Hand Smashed")