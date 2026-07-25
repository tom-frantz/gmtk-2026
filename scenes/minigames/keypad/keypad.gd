extends Node2D

var target_code: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in range(0, 4):
        target_code[i] = randi_range(0, 9)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func render_code() -> void:
    pass
