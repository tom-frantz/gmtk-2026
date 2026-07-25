extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY, 981) # Sets new gravity magnitude
	PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1)) # Sets downward gravity



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var children = find_children('*', 'Area2D') as Array[Grabbable]
	for child in children: 
		var colliding = child.get_overlapping_areas()
		for collision in colliding:
			# Check if all the things we're clipping with are in front of us
			
			pass
		#if child.
