class_name TimeSystem extends Node


signal updated

@export var date_time: DateTime
@export var ticks_per_sec_index: int = 1
@export var ticks_per_sec_options: Array[int] = [2, 4, 8, 16, 32, 64, 128, 256]

var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !OS.is_debug_build():
		return
	
	handle_input()
	
	if is_paused:
		return
	
	date_time.increase_by_sec(delta * ticks_per_sec_options[ticks_per_sec_index])
	updated.emit(date_time)

func handle_input() -> void:
	if Input.is_action_just_pressed("inc_speed"):
		ticks_per_sec_index += 1
	if Input.is_action_just_pressed("dec_speed"):
		ticks_per_sec_index -= 1
	if Input.is_action_just_pressed("pause_time"):
		is_paused = !is_paused
		
	ticks_per_sec_index = clamp(ticks_per_sec_index, 0, ticks_per_sec_options.size() - 1)
	
