extends Label

var target_code: Array[int] = [0, 0, 0, 0]
var output_code: Array[int] = [-1, -1, -1, -1]
var has_won: bool = false

signal correct_combination

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    has_won = false
    for i in range(0, 4):
        target_code[i] = randi_range(0, 9)
    self.text = "".join(target_code.map(func(n): return str(n)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if output_code == target_code and not has_won:
        has_won = true
        emit_signal("correct_combination")
