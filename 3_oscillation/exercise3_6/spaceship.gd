extends Node2D


@export var rot_speed: float = 0.03
@export var acc: float = 1.0
@export var max_speed: int = 3
var velocity: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_rot_input()

	var desired_acc: Vector2 = handle_acc_input()
	self.velocity += desired_acc * acc * delta
	self.velocity = self.velocity.limit_length(max_speed)
	self.global_translate(self.velocity)



func handle_acc_input() -> Vector2:
	var desired_acc: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_accept"):
		desired_acc = Vector2.from_angle(self.rotation)

	return desired_acc


func handle_rot_input():
	if Input.is_action_pressed("ui_left"):
		self.rotate(-rot_speed)

	if Input.is_action_pressed("ui_right"):
		self.rotate(rot_speed)



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

