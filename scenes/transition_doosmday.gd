extends Node2D

var context_length: int
var context_index: int = 0

var context_text: String 

@export_category("Typing Animation")
@export_range(0, 1, 0.01, "prefer_slider", "suffix:s") var min_type_time: float = 0.01
@export_range(0, 1, 0.01, "prefer_slider", "suffix:s") var max_type_time: float = 0.2

var type_timer: Timer
var read_timer: Timer
var context_label: Label
var fade_animation: AnimationPlayer
var long_hand: Sprite2D
var queue_func: Callable

signal finished_typing

func init_nodes() -> void:
    type_timer = %TypeTimer
    read_timer = %ReadTimer
    context_label = %ContextLabel
    fade_animation = %FadeAnimation
    long_hand = %DoomsdayLongHand

func _ready() -> void:
    init_nodes()
    long_hand.rotation_degrees = TransitionGlobals.hand_angle - 90
    context_text = TransitionGlobals.context_text
    context_label.text = ""
    queue_func = queue_type
    fade_animation.play("fade")
    
func queue_type() -> void:
    var type_timeout: float = randf_range(min_type_time, max_type_time)
    type_timer.start(type_timeout)

func type_next() -> void:
    if context_index >= len(context_text):
        type_timer.stop()
        queue_func = queue_next_scene
        read_timer.start()
    else: 
        context_label.text += context_text[context_index]
        context_index += 1
        queue_type()

func queue_next_scene() -> void:
    get_tree().change_scene_to_packed(TransitionGlobals.next_minigame)

func _on_fade_animation_animation_finished(anim_name: StringName) -> void:
    if anim_name == "fade":
        queue_func.call_deferred()

func _on_read_timer_timeout() -> void:
    fade_animation.play_backwards("fade")
