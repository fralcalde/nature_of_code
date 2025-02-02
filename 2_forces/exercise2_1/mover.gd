extends Node2D


var velocity: Vector2 = Vector2.ZERO
var acceleration: Vector2 = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	acceleration = Vector2.ZERO
	apply_force(Vector2.UP * 0.1)
	calc_movement(delta)
	handle_borders()


func apply_force(f: Vector2) -> void:
	acceleration += f


func calc_movement(delta: float) -> void:
	velocity += acceleration * delta
	self.position += velocity


func handle_borders() -> void:
	if self.position.y < 0:
		self.velocity.y *= -1
