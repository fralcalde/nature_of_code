extends Node2D


var velocity: Vector2 = Vector2.ZERO
var acceleration: Vector2
const ACC: float = 0.25
const MAX_VEL: int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	acceleration.x = randf_range(-1, 1)
	acceleration.y = randf_range(-1, 1)
	acceleration = acceleration.normalized() * ACC


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = velocity + acceleration * delta
	velocity = velocity.limit_length(MAX_VEL)
	self.global_position = self.global_position + velocity
	
	handle_borders()


func handle_borders() -> void:
	var viewport_boundaries: Vector2 = get_viewport_rect().end
	
	if self.global_position.x < 0:
		self.global_position.x = viewport_boundaries.x
	
	if viewport_boundaries.x < self.global_position.x:
		self.global_position.x = 0
	
	if self.global_position.y < 0:
		self.global_position.y = viewport_boundaries.y
	
	if viewport_boundaries.y < self.global_position.y:
		self.global_position.y = 0
