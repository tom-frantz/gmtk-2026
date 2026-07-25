extends Label

var target_code: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in range(0, 4):
        target_code.append(randi_range(0, 9))
    self.text = "".join(target_code.map(func(n): return str(n)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass
