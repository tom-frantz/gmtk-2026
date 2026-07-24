extends Node2D

var current_time = 0.0;
# The time for the max fade 
@export_group("Fade settings")
@export var DURATION: float = 10.0
@export var OPACITY_START = 0.99
@export var OPACITY_END = 0.5

var poly: Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	poly = %Polygon2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time += delta
	var lerp = clamp(current_time / DURATION, 0.0, 1.0)
	var opacity = OPACITY_START + (lerp * (OPACITY_END - OPACITY_START)) 
	poly.color.a = opacity
