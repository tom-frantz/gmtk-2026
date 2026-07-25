extends Node2D

var timer: Timer
var background_music: AudioStreamPlayer
var has_won: bool = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("/root/Node2D/LevelTimer/Timer")
	background_music = %background_music


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not background_music.playing and not timer.paused:
		background_music.play()
		
	for child in get_children():
		if child.name in ["LeftHand", "RightHand"] :
			return
	
	# now all hands are gone, we win baybee
	win()

func win():
	var win_banner: Label = %win_banner
	win_banner.visible = true
	timer.paused = true
	background_music.stop()
	if !%win_audio.playing:
		%win_audio.play()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/minigames/evil_usb/minigame_usb.tscn")
