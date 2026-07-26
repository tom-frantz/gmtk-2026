extends Label

@onready
var target_code: Label = %target_code

@onready
var click_sfx: AudioStreamPlayer = %lock_click

var current_digit: int
var tween: Tween
var start_pos: Vector2
var spinning: bool = true

func _ready():
    current_digit = randi_range(0,9)
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

func _on_keypad_input_1_pressed() -> void:
    toggle_spin()
    if !spinning:
        if tween && tween.is_valid():
            tween.stop()
            tween.tween_callback(func():
                target_code.output_code[0] = current_digit
            )
            tween.play()
        else:
            target_code.output_code[0] = current_digit
    else:
        target_code.output_code[0] = -1

func _on_keypad_input_2_pressed() -> void:
    toggle_spin()
    if !spinning:
        if tween && tween.is_valid():
            tween.stop()
            tween.tween_callback(func():
                target_code.output_code[1] = current_digit
            )
            tween.play()
        else:
            target_code.output_code[1] = current_digit
    else:
        target_code.output_code[1] = -1

func _on_keypad_input_3_pressed() -> void:
    toggle_spin()
    if !spinning:
        if tween && tween.is_valid():
            tween.stop()
            tween.tween_callback(func():
                target_code.output_code[2] = current_digit
            )
            tween.play()
        else:
            target_code.output_code[2] = current_digit
    else:
        target_code.output_code[2] = -1

func _on_keypad_input_4_pressed() -> void:
    toggle_spin()
    if !spinning:
        if tween && tween.is_valid():
            tween.stop()
            tween.tween_callback(func():
                target_code.output_code[3] = current_digit
            )
            tween.play()
        else:
            target_code.output_code[3] = current_digit
    else:
        target_code.output_code[3] = -1

func toggle_spin() -> void:
    click_sfx.play()
    if spinning:
        self.position = start_pos
        spinning = false
    else:
        spinning = true
