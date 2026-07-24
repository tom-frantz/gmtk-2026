extends RigidBody2D

class_name Grabbable

static var instances: Array[Grabbable] = []
var joint: PinJoint2D
var is_hovered: bool

func _ready() -> void:
	is_hovered = false
	instances.append(self)
	
func create_joint(hand: Node2D) -> void:
	joint = PinJoint2D.new()
	joint.node_a = self.get_path()
	joint.node_b = hand.get_path()
	self.add_child(joint)
	
func try_grab(hand: Node2D) -> void:
	print("Tried to grab", self.name)
	if not joint:
		create_joint(hand)
	
	
func ungrab() -> void:
	if joint:
		self.remove_child(joint)
		joint = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mb_event: InputEventMouseButton = event
		if not (mb_event).pressed and mb_event.button_index == MOUSE_BUTTON_LEFT:
			ungrab()

func _exit_tree() -> void:
	instances.remove_at(instances.find(self))
