extends Node2D

@export var FOLLOW_SPEED: float = 4.0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	(%CharacterBody2D).position  = (%CharacterBody2D).position.lerp(mouse_pos, delta * FOLLOW_SPEED)

	
func _input(event: InputEvent) -> void:
	var ga: Area2D = %GrabArea
	if event is InputEventMouseButton:
		var mb_event: InputEventMouseButton = event
		if mb_event.pressed and mb_event.button_index == MOUSE_BUTTON_LEFT:
			print("Mouse Clicked")
			if ga.has_overlapping_bodies():
				for ob in ga.get_overlapping_bodies():
					if ob is Grabbable:
						(ob as Grabbable).try_grab((%CharacterBody2D as CharacterBody2D))
			
