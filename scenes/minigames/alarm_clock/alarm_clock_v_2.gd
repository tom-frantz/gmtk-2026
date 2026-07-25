extends Node2D

var timer: Timer
var background_music: AudioStreamPlayer
var has_won: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY, 981) # Sets new gravity magnitude
    PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1)) # Sets downward gravity
    %background_music.play()
    timer = get_node("/root/AlarmClockV2/LevelTimer/Timer")
    background_music = %background_music


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if not background_music.playing and not timer.paused:
        background_music.play()


func _on_alarm_clock_my_fuckin_ace_signal(body: Node2D) -> void:
    # Winner winner, chicken dinner.
    var win_banner: Label = %win_banner
    win_banner.visible = true
    timer.paused = true
    background_music.stop()
    if !%win_audio.playing:
        %win_audio.play()
    await get_tree().create_timer(2.0).timeout
    get_tree().change_scene_to_file("res://scenes/minigames/keypad/minigame_keypad.tscn")
