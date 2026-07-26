extends Area2D

var lamp_on: bool = true
var tween: Tween
var rest_position: Vector2
var dragging: bool = false
var velocity: Vector2
var mouse_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	rest_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("left_click"):
		dragging = false
	if !tween:
		tween = self.create_tween()
		tween.tween_property(self, "rotation_degrees", self.rotation_degrees + 2, 5)
		tween.tween_property(self, "rotation_degrees", self.rotation_degrees - 1, 5)
		tween.tween_property(self, "rotation_degrees", self.rotation_degrees, 5)
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_loops()
		tween.play()
	
	if dragging:
		var target = get_viewport().get_mouse_position() + mouse_offset
		target.x = rest_position.x
		target.y = clamp(target.y, rest_position.y, rest_position.y + 80)
		position = target
	else:
		var displacement = position - rest_position
		var acceleration = (-20 * displacement) - (6 * velocity)
		velocity += acceleration * delta
		position += velocity * delta
		if displacement.length() < 0.2 and velocity.length() < 0.2:
			position = rest_position
			velocity = Vector2.ZERO

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		dragging = true
		velocity = Vector2.ZERO
		mouse_offset = position - get_viewport().get_mouse_position()
		
func _on_start_area_area_entered(area: Area2D) -> void:
	if lamp_on:
		lamp_on = false
		var click: AudioStreamPlayer = %lamp_click
		click.play()
		%light.enabled = false
		await get_tree().create_timer(0.5).timeout
		start_game.call_deferred()
		
func start_game():
	get_tree().change_scene_to_file("res://scenes/minigames/alarm_clock/alarm_clock_v2.tscn")
	
