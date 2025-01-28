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
	var rand_num: int = randi_range(0, max_number - 1)
	var bar: ProgressBar = progress_bars[rand_num]
	bar.value += 1
