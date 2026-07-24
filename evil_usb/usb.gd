extends RigidBody2D
var solved: bool = false
@onready
var usb_sprite: AnimatedSprite2D = %usb_sprite

@onready
var animation_player: AnimationPlayer= %AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !solved:
		if usb_sprite.frame == 3:
			self.collision_mask = 0b00000000_00000000_00000000_00000010
		else:
			self.collision_mask = 0b00000000_00000000_00000000_00000001
		var vector: Vector2 = Vector2(get_viewport().get_mouse_position()- position)
		move_and_collide(vector)
		# position = position.lerp(get_viewport().get_mouse_position(), 2*delta)
		if Input.is_action_just_pressed("left_click"):
			usb_flip()

func usb_flip() -> void:
	if usb_sprite.frame == 3:
		usb_sprite.frame = 0
	else:
		usb_sprite.frame += 1

func _on_slot_area_entered(area: Area2D, source: Area2D) -> void:
	if usb_sprite.frame == 3:
		solved = true

		animation_player.play("w2")
		print("correct")

func _on_slot_body_entered(body: Node2D) -> void:
	if usb_sprite.frame == 3:
		solved = true

		animation_player.play("w2")
		print("correct")
