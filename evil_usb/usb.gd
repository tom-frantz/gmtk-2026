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
var incorrect_audio: AudioStreamPlayer = %incorrect_audio

@onready
var status: UsbStatus = UsbStatus.FREE

@onready
var orient: UsbOrient = UsbOrient.A

@onready
var tween: Tween

const win_orient: UsbOrient = UsbOrient.C

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !tween:
		self.rotation_degrees = 0;
		usb_sprite.rotation_degrees = 0;

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
	if status != UsbStatus.WON && status != UsbStatus.REJECT:
		print(status)
		var target_pos: Vector2 = lerp(self.global_position, get_viewport().get_mouse_position(), 0.5)
		var displacement: Vector2 = target_pos - self.global_position
		var collision: KinematicCollision2D  = move_and_collide(displacement)

		if collision && !tween:
			var obj: Node2D = collision.get_collider()
			if obj.name == "slot_body":
				bounce_away(collision)

func bounce_away(collision: KinematicCollision2D) -> void:
	status = UsbStatus.REJECT
	tween = self.create_tween()
	incorrect_audio.play()
	tween.tween_property(self, "position", self.position + 30*collision.get_normal() , 0.2)
	tween.tween_property(self, "rotation_degrees", self.rotation_degrees + 5, 0.2)
	tween.tween_property(self, "rotation_degrees", self.rotation_degrees - 5, 0.2)
	tween.tween_property(self, "rotation_degrees", self.rotation_degrees, 0.2)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	tween.finished.connect(_on_animation_completed)

func _on_animation_completed() -> void:
	tween.stop()
	tween = null
	status = UsbStatus.FREE

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
