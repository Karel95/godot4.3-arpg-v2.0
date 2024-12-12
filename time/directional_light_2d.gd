extends DirectionalLight2D


@export var day_color: Color
@export var night_color: Color
@export var day_start: DateTime
@export var night_start: DateTime
@export var transition_time: int = 30 #in minutes
@export var time_system: TimeSystem

enum DayState {DAY, NIGHT}
var current_state: DayState = DayState.DAY
var in_transition: bool = false

@onready var time_map: Dictionary = {
	DayState.DAY: day_start,
	DayState.NIGHT: night_start,
}

@onready var transition_map: Dictionary = {
	DayState.DAY: DayState.NIGHT,
	DayState.NIGHT: DayState.DAY,
}

@onready var color_map: Dictionary = {
	DayState.DAY: day_color,
	DayState.NIGHT: night_color,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var diff_day_start = time_system.date_time.diff_without_days(day_start)
	var diff_night_start = time_system.date_time.diff_without_days(night_start)
	
	if diff_day_start < 0 || diff_night_start > 0:
		current_state = DayState.NIGHT
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_time_system_updated(game_time: DateTime) -> void:
	var next_state = transition_map[current_state]
	var change_time = time_map[next_state]
	var time_diff = change_time.diff_without_days(game_time)
	
	if in_transition:
		update_transition(time_diff, next_state)
	elif time_diff > 0 && time_diff < (transition_time * 60):
		in_transition = true
		update_transition(time_diff, next_state)
	else:
		color = color_map[current_state]
	

func update_transition(time_diff: int, next_state: DayState) -> void:
	var ratio = 1 - (time_diff as float/(transition_time * 60))
	
	if ratio > 1:
		current_state = next_state
		in_transition = false
	else:
		color = color_map[current_state].lerp(color_map[next_state], ratio)
		
	
