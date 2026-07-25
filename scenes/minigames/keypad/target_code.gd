extends Label

var target_code: Array[int] = [0, 0, 0, 0]
var output_code: Array[int] = [-1, -1, -1, -1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in range(0, 4):
        target_code[i] = randi_range(0, 9)
    self.text = "".join(target_code.map(func(n): return str(n)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    # print(output_code)
    if output_code == target_code:
        win()

func win() -> void:
    var win_audio: AudioStreamPlayer = %win_audio
    var win_banner: Label = %win_banner
    var timer: Timer = $"../LevelTimer/Timer"
    # var background_music: AudioStreamPlayer = %background_music
    # background_music.stop()
    win_banner.visible = true
    timer.paused = true
    if !win_audio.playing:
        win_audio.play()
    await get_tree().create_timer(2.0).timeout
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
