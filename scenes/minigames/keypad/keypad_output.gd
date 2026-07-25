extends Label

var output_code: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    self.text = "".join(output_code.map(func(n): return str(n)))

# func update_output(current_digit)
