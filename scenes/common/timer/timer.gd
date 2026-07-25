@tool
extends Node2D

class_name DigitalTimer2D

const DIGIT_WIDTH = 50
const MIN_UNIT_IN_SECONDS = 10

signal timeout

@export var show_minutes: bool = true:
	set(value):
		show_minutes = value
		if Engine.is_editor_hint():
			update_minute_visibility()

var timer: Timer
var digits: Array[TimerDigit2D]

func _ready() -> void:
	timer = %Timer
	digits = [
		%minute_tens,
		%minute_digits,
		%second_tens,
		%second_digits,
		%deciseconds
	]
	update_minute_visibility()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var time_left: int = int(timer.time_left * MIN_UNIT_IN_SECONDS)
	for d in digits:
		time_left = d.update_time(time_left)

func update_minute_visibility() -> void:
	if show_minutes:
		(%minute_tens as Node2D).show()
		(%minute_digits as Node2D).show()
		(%double_dots as Node2D).show()
		(%visuals as Node2D).position.x = 0
	else:
		(%minute_tens as Node2D).hide()
		(%minute_digits as Node2D).hide()
		(%double_dots as Node2D).hide()
	
		var left_x: float = (%second_tens as Node2D).position.x
		var right_x: float = (%deciseconds as Node2D).position.x
		var offset_x: float = (right_x + left_x + DIGIT_WIDTH) / 2
		(%visuals as Node2D).position.x = -offset_x


func _on_timer_timeout() -> void:
	emit_signal("timeout")
