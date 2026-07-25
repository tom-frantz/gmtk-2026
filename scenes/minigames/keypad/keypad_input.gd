extends Label

@onready
var keypad_output: Label = %keypad_output

var current_digit := 0
var tween: Tween
var start_pos: Vector2
var spinning: bool = true

func _ready():
    start_pos = position
    text = str(current_digit)

func _process(_delta):
    # only re-render every few frames
    if Engine.get_process_frames() % 15 == 0 && spinning:
        render_digit()

func render_digit() -> void:
    if tween and tween.is_valid():
        tween.kill()

    tween = create_tween()

    tween.tween_property(self, "position", start_pos + Vector2(0, -20), 0.08)

    tween.tween_callback(func():
        current_digit = (current_digit + 1) % 10
        text = str(current_digit)
        position = start_pos + Vector2(0, 20)
    )

    tween.tween_property(self, "position", start_pos, 0.08)

    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_OUT)

func _on_texture_button_pressed() -> void:
    if spinning:
        self.position = start_pos
        spinning = false
        keypad_output.output_code.append(current_digit)
    else:
        spinning = true
