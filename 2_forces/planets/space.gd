extends Node3D


var planets: Array = []
@export var GRAV_CONST: float = 0.075


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Planet:
			var v: Vector3 = Vector3(
				randf_range(-5, 5),
				randf_range(-5, 5),
				randf_range(-5, 5)
				)
			child.set_velocity(v)
			planets.append(child)


func _process(_delta: float) -> void:
	for p1 in planets:
		for p2 in planets:
			if p1 != p2:
				gravitate(p1, p2)


func gravitate(p1: Planet, p2: Planet) -> void:
	var direction: Vector3 = p2.global_position - p1.global_position
	var distance: float = direction.length()
	if distance < 1:
		return

	direction = direction.normalized()


	var f_force: float = (GRAV_CONST * p1.mass * p2.mass) / (distance * distance)
	var f: Vector3 = f_force * direction

	p1.apply_force(f)
