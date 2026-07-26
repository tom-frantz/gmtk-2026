extends ProgressBar

signal win
var has_won: bool = false
var status: int = 0

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
            %status.frame +=1
            if %status.frame == 3:
                has_won = true
                emit_signal("win")
            else:
                value = 0

func _on_texture_button_pressed() -> void:
    value +=12
