extends Area2D
var solved = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !solved:
		position = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("left_click"):
		usb_flip()


func _on_slot_collision_area_area_entered(area: Area2D, vec: PackedVector2Array) -> void:
	print(vec)
	var usb_sprite: AnimatedSprite2D = area.get_child(0)
	if usb_sprite.frame == 3:
		solved = true
		#usb_sprite.position = 
		print("correct")

func usb_flip() -> void:
	var usb_sprite: AnimatedSprite2D = self.get_child(0)
	if usb_sprite.frame == 3:
		usb_sprite.frame = 0
	else:
		usb_sprite.frame += 1
		
func win():
	pass
