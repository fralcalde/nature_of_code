extends Node2D
# Achieved by making more possible steps to the right and down
# than steps left and up.
# Could also be done by giving bigger chances of right and down.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stepx: int = randi_range(-1, 2)
	var stepy: int = randi_range(-1, 2)
	var step: Vector2 = Vector2(stepx, stepy)
	
	self.global_position += step
