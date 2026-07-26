extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if !%bgm.playing:
        %bgm.play()
    var transform = Vector2(0,-1)
    self.set_position(self.position + transform)
    
    #hack
    if self.position.y == -1200:
        %bgm.stop()
        await get_tree().create_timer(0.5)
        get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
