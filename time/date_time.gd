class_name DateTime extends Resource


@export_range(0, 59) var seconds: int = 0
@export_range(0, 59) var minutes: int = 0
@export_range(0, 24) var hours: int = 0
@export var days: int = 0

var delta_time: float = 0

func increase_by_sec(delta_seconds: float) -> void:
	delta_time += delta_seconds
	if delta_time < 1: return
	
