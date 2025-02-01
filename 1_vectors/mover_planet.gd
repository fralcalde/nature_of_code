extends Node2D


var acceleration: Vector2 = Vector2.ZERO
const ACC_MAG: float = 0.25

var velocity: Vector2 = Vector2.ZERO
const VEL_MAX: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var desired_dir = mouse_pos - self.global_position
	
	acceleration = desired_dir.normalized() * sqrt(desired_dir.length())
	velocity += acceleration * delta
	self.global_position += velocity
