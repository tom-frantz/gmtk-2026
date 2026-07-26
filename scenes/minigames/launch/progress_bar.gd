extends ProgressBar

signal win
var has_won: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    %laptop_screen.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    self.visible = true
    if %laptop_screen.frame == 0:
        self.visible = false
    if value < 100:
        self.value -= 0.3
    else:
        if !has_won:
            has_won = true
            emit_signal("win")

func _on_texture_button_pressed() -> void:
    value +=12
