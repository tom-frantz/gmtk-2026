extends Node2D


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
