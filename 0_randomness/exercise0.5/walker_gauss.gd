extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var stepx: float = randfn(0, 1)
	var stepy: float = randfn(0, 1)
	var step: Vector2 = Vector2(stepx, stepy)
	
	self.global_position += step
