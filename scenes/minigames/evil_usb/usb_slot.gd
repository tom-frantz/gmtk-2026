extends Node2D

enum SlotOrient{
        A,
        B,
        C,
        D,
}

var slot_orient: SlotOrient

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var x_offset = randi_range(-100, 170)
    var y_offset = randi_range(0, 100)
    self.global_position += Vector2(x_offset, y_offset)
    slot_orient = randi_range(0,3)
    %slot_sprite.frame = slot_orient
    %slot_mask.frame = slot_orient
    %usb.win_orient = slot_orient
    
    # hack: move mask up a few pixels if slot is vertical
    var top_of_slot_pos = %slot_mask.position
    if slot_orient == SlotOrient.B || slot_orient == SlotOrient.D:
        %computah_mask.position.y -= 12
        %slot_mask.global_position = top_of_slot_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
