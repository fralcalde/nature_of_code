extends Node2D


@export var max_angle: float = 10
@export_range(0.0, 2.0) var angle_step: float = 0.1
@export var radius_step: float = 1.0
@export var start_angle: float = 0.0
var current_angle: float = angle_step
var current_radius: float = 0.0
@onready var line: Line2D = %Line



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var new_point: Vector2 = Vector2.from_angle(current_angle) * current_radius
	line.add_point(new_point)
	current_angle += angle_step
	current_radius += radius_step

	if current_angle > max_angle:
		self.set_process(false)
