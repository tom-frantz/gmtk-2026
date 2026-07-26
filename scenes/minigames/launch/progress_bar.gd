extends ProgressBar

signal win
var has_won: bool = false
var laptop_screen: AnimatedSprite2D
@export var launch_decay: float = 5
@export var button_value: float = 9

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    laptop_screen = %laptop_screen
    laptop_screen.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    self.visible = true
    if laptop_screen.frame == 0:
        self.visible = false
    if value < 100:
        self.value -= launch_decay * delta
    else:
        if !has_won:
            %status.frame +=1
            if %status.frame == 3:
                has_won = true
                emit_signal("win")
            else:
                value = 0

func _on_texture_button_pressed() -> void:
    value += button_value
