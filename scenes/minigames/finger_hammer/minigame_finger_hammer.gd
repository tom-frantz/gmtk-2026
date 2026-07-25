extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if %LeftHand.is_hand_smashed && %RightHand.is_hand_smashed:
        win()
    
func win() -> void:
    await get_tree().create_timer(2.0).timeout
    get_tree().change_scene_to_file("res://scenes/minigames/launch/minigame_launch.tscn")
