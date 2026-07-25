extends Area2D

class_name CrumpledTicket

signal fully_uncrumpled

const FULLY_UNCRUMPLED_FRAME: int = 7

# var is_clicked
@export var drag_distance: float = 200
var is_hovered: bool = false
var dragged: float = 0
var mouse_last: Vector2 = Vector2.INF
var ticket_sprite: Sprite2D
var ticket_collider: CollisionShape2D

const HOVER_HEIGHTS: Array[float] = [   31, 36, 36, 42, 48, 58, 62, 62 ]
const HOVER_Y: Array[float]       = [ 15.5, 13, 13, 10,  7,  2,  0,  0 ]

func _ready() -> void:
    ticket_sprite = %TicketSprite
    ticket_collider = %TicketHover

func _process(_delta: float) -> void:
    var mouse_current: Vector2 = get_local_mouse_position()

    if is_hovered:
        var delta_x: float = mouse_last.y - mouse_current.y
        if delta_x > 0:
            dragged += delta_x
        if dragged >= drag_distance:
            uncrumple()

    mouse_last = mouse_current

func uncrumple() -> void:
    ticket_sprite.frame += 1
    var tc_shape: RectangleShape2D = ticket_collider.shape
    tc_shape.size.y = HOVER_HEIGHTS[ticket_sprite.frame]
    ticket_collider.position.y = HOVER_Y[ticket_sprite.frame]
    dragged = 0
    if ticket_sprite.frame == FULLY_UNCRUMPLED_FRAME:
        emit_signal("fully_uncrumpled")

func _on_mouse_shape_exited(_shape_idx: int) -> void:
    is_hovered = false

func _on_mouse_shape_entered(_shape_idx: int) -> void:
    is_hovered = true
