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
	

func usb_flip() -> void:
	if %usb_sprite.frame == 3:
		%usb_sprite.frame = 0
	else:
		%usb_sprite.frame += 1

#func win(a):
	#var usb_sprite: AnimatedSprite2D = self.get_child(0)
	#print(self.global_position)
	#var usb_sprite: AnimatedSprite2D = area.get_child(0)
	#print(source.get_child(0).position)
	#print(usb_sprite.position)
	#usb_sprite.position = source.get_child(0).position
	#print("correct")

func _on_slot_area_entered(area: Area2D, source: Area2D) -> void:
	if %usb_sprite.frame == 3:
		solved = true
		#var offset: Vector2 = Vector2(0, 50)
		#print(%usb_sprite.global_position)
		#print(%slot_sprite.global_position)
		#%usb_sprite.top_level = true
		#self.global_position = %slot_sprite.global_position

		%AnimationPlayer.play("w2")
		print("correct")
