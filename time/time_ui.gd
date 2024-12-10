extends Control


@onready var days_label: Label = $DayControl/days
@onready var hours_label: Label = $ClockControl/hours
@onready var mins_label: Label = $ClockControl/mins
@onready var secs_label: Label = $ClockControl/secs


func _on_time_system_updated(date_time: DateTime) -> void:
	update_label(days_label, date_time.days, false)
	update_label(hours_label, date_time.hours)
	update_label(mins_label, date_time.minutes)
	update_label(secs_label, date_time.seconds)
	
	print_debug((str(date_time.days) + ':' + str(date_time.hours) + ':' + str(date_time.minutes) + ':' + str(date_time.seconds)))


func add_leading_zero(label: Label, value: int) -> void:
	if value < 10:
		label.text += '0'

func update_label(label: Label, value: int, should_have_zero: bool = true) -> void:
	label.text = ''
	if should_have_zero:
		add_leading_zero(label, value)
		
	label.text += str(value)
	
