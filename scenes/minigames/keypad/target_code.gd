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
	var success_color =  Color(0.219, 0.783, 0.212, 1.0)
	var error_color =  Color(0.808, 0.182, 0.179, 1.0)
	
	if target_code[0] == output_code[0]:
		$"../keypad_input_1/Polygon2D".color = success_color
	else:
		$"../keypad_input_1/Polygon2D".color = error_color
		
	if target_code[1] == output_code[1]:
		$"../keypad_input_2/Polygon2D".color = success_color
	else:
		$"../keypad_input_2/Polygon2D".color = error_color
		
	if target_code[2] == output_code[2]:
		$"../keypad_input_3/Polygon2D".color = success_color
	else:
		$"../keypad_input_3/Polygon2D".color = error_color
		
	if target_code[3] == output_code[3]:
		$"../keypad_input_4/Polygon2D".color = success_color
	else:
		$"../keypad_input_4/Polygon2D".color = error_color
		
	
	if output_code == target_code and not has_won:
		has_won = true
		emit_signal("correct_combination")
