@tool
extends Sprite2D

class_name TimerDigit2D

@export_range(0, 9, 1, "or_greater", "or_less", "prefer_slider") var digit: int = 0:
    set(value):
        digit = value
        if Engine.is_editor_hint():
            frame = digit
@export var divisor: int = 1

func _init() -> void:
    frame = digit

func update_time(time: int) -> int:
    digit = time / divisor
    # digit = ceili((time as float) / (divisor as float))
    frame = digit
    return time % divisor