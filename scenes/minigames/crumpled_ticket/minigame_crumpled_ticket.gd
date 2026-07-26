extends Node2D

var background_music: AudioStreamPlayer
var timer: Timer
var win_audio: AudioStreamPlayer
var has_won: bool = false;

@export_range(0, 100, 0.1, "suffix:s", "prefer_slider") \
    var time_left: float = 30

func _ready() -> void:
    background_music = %background_music
    timer = (%LevelTimer as DigitalTimer2D).timer
    win_audio = %win_audio
    background_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if not background_music.playing and not timer.paused:
        background_music.play()

func _on_crumpled_ticket_fully_uncrumpled() -> void:
    # Winner winner, chicken dinner.
    var win_banner: Label = %win_banner
    win_banner.visible = true
    timer.paused = true
    background_music.stop()
    if not win_audio.playing:
        win_audio.play()
    await get_tree().create_timer(2.0).timeout
    get_tree().change_scene_to_file("res://scenes/minigames/evil_usb/minigame_usb.tscn")
