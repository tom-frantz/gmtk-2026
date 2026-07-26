extends Node2D

class_name DigitalTimer2D

const DIGIT_WIDTH: int = 50
const MIN_UNIT_IN_SECONDS: int = 10

signal timeout

@export var show_minutes: bool = true

var timer: Timer
var visuals: Node2D
var minute_tens: Node2D
var minute_digits: Node2D
var second_tens: Node2D
var second_digits: Node2D
var deciseconds: Node2D
var double_dots: Node2D
var digits: Array[TimerDigit2D]

func init_nodes() -> void:
    timer = %Timer
    minute_tens = %minute_tens
    minute_digits = %minute_digits
    second_tens = %second_tens
    second_digits = %second_digits
    deciseconds = %deciseconds
    double_dots = %double_dots
    visuals = %visuals

func _ready() -> void:
    init_nodes()
    digits = [
        minute_tens,
        minute_digits,
        second_tens,
        second_digits,
        deciseconds
    ]
    update_minute_visibility()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if timer:
        var time_left: int = int(timer.time_left * MIN_UNIT_IN_SECONDS)
        for d:TimerDigit2D in digits:
            time_left = d.update_time(time_left)

func update_minute_visibility() -> void:
    if show_minutes:
        minute_tens.show()
        minute_digits.show()
        double_dots.show()
        visuals.position.x = 0
    else:
        minute_tens.hide()
        minute_digits.hide()
        double_dots.hide()
    
        var left_x: float = second_tens.position.x
        var right_x: float = deciseconds.position.x
        var offset_x: float = (right_x + left_x + DIGIT_WIDTH) / 2
        visuals.position.x = -offset_x


func _on_timer_timeout() -> void:
    emit_signal("timeout")
