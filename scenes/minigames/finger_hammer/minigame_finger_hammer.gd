extends Node2D

var has_won: bool = false
var left_hand: HangingHand2D
var right_hand: HangingHand2D

signal win

func _ready() -> void:
    has_won = false
    left_hand = %LeftHand
    right_hand = %RightHand
    (%FadeAnimation as AnimationPlayer).play("fade")

func _on_hand_smashed() -> void:
    if not left_hand or left_hand.is_hand_smashed:
        if not right_hand or right_hand.is_hand_smashed:
            if not has_won:
                has_won = true
                await get_tree().create_timer(1).timeout
                %splash_sfx.play()
                emit_signal("win")
