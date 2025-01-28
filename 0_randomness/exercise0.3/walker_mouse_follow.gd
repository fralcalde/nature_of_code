extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var choice: float = randf()
	
	var move: Vector2
	if choice < 0.1:
		move = Vector2.UP
	elif choice < 0.2:
		move = Vector2.DOWN
	elif choice < 0.3:
		move = Vector2.RIGHT
	elif choice < 0.4:
		move = Vector2.LEFT
	elif choice < 0.5:
		move = Vector2.ZERO
	else:
		var mouse_pos = get_global_mouse_position()
		var my_pos = self.global_position
		move = (mouse_pos - my_pos).normalized()
	
	self.global_position += move
