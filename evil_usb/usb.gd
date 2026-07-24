extends RigidBody2D

enum UsbStatus{
		FREE,
		REJECT,
		ENTERING,
		WON
}

enum UsbOrient{
		A,
		B,
		C,
		D,
}

@onready
var usb_sprite: AnimatedSprite2D = %usb_sprite

@onready
var slot_mask: Sprite2D = %computah_mask

@onready
var animation_player: AnimationPlayer= %AnimationPlayer

@onready
var status: UsbStatus = UsbStatus.FREE

@onready
var orient: UsbOrient = UsbOrient.A

const win_orient: UsbOrient = UsbOrient.C

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_won()
	update_collisions()
	move_usb()
	if Input.is_action_just_pressed("left_click"):
		usb_flip()
	render_usb()

func check_won() -> void:
	if status == UsbStatus.WON:
		print("won!")

func update_collisions() -> void:
	var free: int = 0b00000000_00000000_00000000_00000010
	var blocked: int = 0b00000000_00000000_00000000_00000001
	var entering: int = 0b00000000_00000000_00000000_00000100
	self.collision_mask = blocked
	if orient == win_orient:
		self.collision_mask = free
		if status == UsbStatus.ENTERING:
			self.collision_mask |= entering

func move_usb() -> void:
	if status != UsbStatus.WON:
		var vector: Vector2 = Vector2(get_viewport().get_mouse_position()- position)
		move_and_collide(vector)

func usb_flip() -> void:
	match orient:
		UsbOrient.A:
			orient = UsbOrient.B
		UsbOrient.B:
			orient = UsbOrient.C
		UsbOrient.C:
			orient = UsbOrient.D
		UsbOrient.D:
			orient = UsbOrient.A

func render_usb() -> void:
	match orient:
		UsbOrient.A:
			usb_sprite.frame = 0
		UsbOrient.B:
			usb_sprite.frame = 1
		UsbOrient.C:
			usb_sprite.frame = 2
		UsbOrient.D:
			usb_sprite.frame = 3

# When  hitting the win collision
func _on_slot_body_entered(_body: Node2D) -> void:
	if (status == UsbStatus.ENTERING && orient == win_orient):
		status = UsbStatus.WON

# When entering
func _on_slot_entered_collision_body_entered(_body: Node2D) -> void:
	if orient == win_orient:
		slot_mask.z_index = 2
		status = UsbStatus.ENTERING

# When exiting
func _on_slot_entered_collision_body_exited(_body: Node2D) -> void:
	slot_mask.z_index = -1
	status = UsbStatus.FREE
