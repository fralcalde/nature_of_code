extends Node2D


@export var acc: float = 5.0
@export var max_speed: float = 2.0
var velocity: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var desired_acc: Vector2 = handle_input() 
	self.velocity += desired_acc * self.acc * delta
	self.velocity = self.velocity.limit_length(max_speed)
	self.global_position += self.velocity

	var angle: float = atan2(self.velocity.y, self.velocity.x)
	self.rotation = angle

	handle_borders()


func handle_input() -> Vector2:
	var desired_acc: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		desired_acc += Vector2.UP

	if Input.is_action_pressed("ui_down"):
		desired_acc += Vector2.DOWN

	if Input.is_action_pressed("ui_left"):
		desired_acc += Vector2.LEFT

	if Input.is_action_pressed("ui_right"):
		desired_acc += Vector2.RIGHT

	return desired_acc.normalized()



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

