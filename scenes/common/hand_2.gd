extends CharacterBody2D

var current_collisions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	position = mouse_pos
	
func _input(event: InputEvent) -> void:
	var ga: Area2D = %GrabArea
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Mouse Clicked")
			if ga.has_overlapping_bodies():
				for ob in ga.get_overlapping_bodies():
					if ob is Grabbable:
						ob.try_grab(self)
			
