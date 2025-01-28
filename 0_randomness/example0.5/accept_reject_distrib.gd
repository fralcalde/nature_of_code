extends Control

@export_range(1, 50) var max_number: int = 20
var progress_bars: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(max_number):
		var new_bar: ProgressBar = ProgressBar.new()
		new_bar.show_percentage = false
		progress_bars.append(new_bar)
		%VBoxContainer.add_child(new_bar)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var rand_num: float = accept_reject()
	
	var bar_num: int = floor(rand_num * max_number)
	var bar: ProgressBar = progress_bars[bar_num]
	bar.value += 1


func accept_reject() -> float:
	while(true):
		var rand_num: float = randf()
		var qualify_proba: float = rand_num
		var qualify_res: float = randf()
		
		if qualify_res < qualify_proba:
			return rand_num
	
	return 0.0  # Otherwise, godot complains...
