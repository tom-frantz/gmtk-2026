extends Polygon2D

var current_time = 0.0;
# The time for the max fade 
var TIME_TO_COMPLETE: float = 10.0
var OPACITY_START = 0.99
var OPACITY_END = 0.5



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time += delta
	var lerp = clamp(current_time / TIME_TO_COMPLETE, 0.0, 1.0)
	var opacity = OPACITY_START + (lerp * (OPACITY_END - OPACITY_START)) 
	color.a = opacity
