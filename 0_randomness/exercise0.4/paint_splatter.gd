extends Node2D


var color: Color
@export_range(0.0, 1.0) var transparency: float = 0.4
var dot_scene: PackedScene = preload("res://exercise0.4/dot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var r: float = randf()
	var g: float = randf()
	var b: float = randf()
	
	color = Color(r, g, b, transparency)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var max_x: int = get_viewport_rect().end.x
	var max_y: int = get_viewport_rect().end.y
	
	var mean_x: float = max_x / 2.0
	var mean_y: float = max_y / 2.0
	
	var r_x: float = randfn(mean_x, sqrt(max_x) * 4)
	var r_y: float = randfn(mean_y, sqrt(max_y) * 4)
	
	var r_pos: Vector2 = Vector2(r_x, r_y)
	
	
	var r: float = remap(r_pos.x, 0.0, max_x, 0.0, 1.0)
	var g: float = remap(r_pos.y, 0.0, max_y, 0.0, 1.0)
	var angle: float = Vector2(mean_x, mean_y).angle_to_point(r_pos)
	var b: float = remap(angle, -PI, PI, 0.0, 1.0)
	var positional_color: Color = Color(r, g, b, transparency)
	
	var new_dot: Polygon2D = dot_scene.instantiate()
	new_dot.color = positional_color
	new_dot.global_position = r_pos
	add_child(new_dot)
