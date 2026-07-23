extends RigidBody2D

class_name Grabbable

static var instances: Array[Grabbable] = []
var joint: PinJoint2D
var is_hovered: bool

func _ready() -> void:
	is_hovered = false
	instances.append(self)
	
func create_joint(hand: CharacterBody2D):
	joint = PinJoint2D.new()
	joint.node_a = self.get_path()
	joint.node_b = hand.get_path()
	self.add_child(joint)
	
func try_grab(hand: CharacterBody2D):
	print("Tried to grab", self.name)
	if not joint:
		create_joint(hand)
	
	
func ungrab():
	if joint:
		self.remove_child(joint)
		joint = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			ungrab()

func _exit_tree() -> void:
	instances.remove_at(instances.find(self))
