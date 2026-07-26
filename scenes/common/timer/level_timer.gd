extends Node2D

class_name LevelTimer

@export_range(0, 120, 0.1, "suffix:s", "prefer_slider") var lose_timeout: float
@export_range(0, 90, 1, "degrees", "prefer_slider") var transition_hand_angle: float
@export var transition_scene: PackedScene
@export var transition_text: String
@export var next_minigame: PackedScene
@export var lose_scene: PackedScene
@export var background_music: AudioStream
var background_music_player: AudioStreamPlayer
var lose_timer: DigitalTimer2D
var lose_screen: Node2D
var lose_audio: AudioStreamPlayer
var win_screen: Node2D
var win_audio: AudioStreamPlayer

func _ready() -> void:
	background_music_player = %BackgroundMusic
	lose_timer = %LoseTimer
	lose_screen = %Lose
	lose_audio = %LoseAudio
	win_screen = %Win
	win_audio = %WinAudio
	if background_music:
		background_music_player.stream = background_music
		background_music_player.play()
	lose_timer.timer.start(lose_timeout)
	
func on_win() -> void:
	background_music_player.stop()
	lose_timer.timer.stop()
	win_screen.show()
	win_audio.play()

func on_lose() -> void:
	if background_music:
		background_music_player.stop()
	lose_timer.timer.stop()
	lose_screen.show()
	lose_audio.play()

func queue_lose_level() -> void:
	lose_level.call_deferred()

func lose_level() -> void:
	TransitionGlobals.hand_angle = 0
	TransitionGlobals.next_minigame = lose_scene
	TransitionGlobals.context_text = "I guess I wasn't fast enough... I'll try again tomorrow."
	get_tree().change_scene_to_packed(transition_scene)

func queue_next_level() -> void:
	next_level.call_deferred()

func next_level() -> void:
	TransitionGlobals.hand_angle = transition_hand_angle
	TransitionGlobals.next_minigame = next_minigame
	TransitionGlobals.context_text = transition_text
	get_tree().change_scene_to_packed(transition_scene)

func _on_lose_timer_timeout() -> void:
	on_lose()
