extends ProgressBar

@onready
var win_audio: AudioStreamPlayer = $"../win_audio"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if value < 100:
        self.value -= 0.3
    else:
        win()

func _on_texture_button_pressed() -> void:
    value +=6

func win() -> void:
    var win_banner: Label = %win_banner
    win_banner.visible = true
    var timer: Timer = $"../LevelTimer/Timer"
    timer.paused = true
    if !win_audio.playing:
        win_audio.play()
    await get_tree().create_timer(2.0).timeout
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
