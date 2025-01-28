extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var stepx: float = accept_reject()
	var stepy: float = accept_reject()
	var step: Vector2 = Vector2(stepx, stepy)

	self.global_position += step


func accept_reject() -> float:
	var rand_num: float = randf_range(-1.0, 1.0)
	var qualify_proba: float = sqrt(abs(rand_num))
	var qualify_res: float = randf()
	
	if qualify_res < qualify_proba:
		return rand_num
	
	return accept_reject()
