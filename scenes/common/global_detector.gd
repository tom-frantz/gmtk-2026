extends Area2D


func collision_mask(item: Node2D) -> int:
	var parent = item.get_parent()
	if item is CollisionObject2D:
		return parent.collision_layer
	return 0 
	

# Return the log2(mask)
func log_mask(mask: int) -> int:
	return log(mask) / log(2)


var frame_count: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Areas aren't initialised properly on first frame, simply skip calcs for it.
	if frame_count < 2:
		frame_count += 1;
		return
	
	var debug: bool = get_parent().name == "DrinkBottle"
	debug = false;
	var current_log_mask = log_mask(collision_mask(self))
	var largest_log_mask: int = -1;
	for overlapping in get_overlapping_areas():
		# Get the log 2 of the collision mask
		var log_mask = log_mask(collision_mask(overlapping)) 
		if debug: 
			print("colliding with ", overlapping.get_parent().name)
		
		if log_mask > current_log_mask:
			continue
		elif largest_log_mask < log_mask:
			largest_log_mask = log_mask
		
			
	if debug: 
		print("Current: ", current_log_mask)
		print("largest: ", largest_log_mask)
	if current_log_mask > largest_log_mask + 1:
		self.get_parent().collision_layer = 1 << (largest_log_mask + 1)
		self.get_parent().collision_mask = 1 << (largest_log_mask + 1)
		if debug:
			print("bringing forwards")
			
	
