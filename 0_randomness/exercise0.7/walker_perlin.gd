extends Node2D


var noise_gen_x: FastNoiseLite
var noise_gen_y: FastNoiseLite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise_gen_x = get_noise_gen(randi(), 5, 0.0005)
	noise_gen_y = get_noise_gen(randi(), 5, 0.0005)
	
	var tex: ImageTexture = ImageTexture.create_from_image(noise_gen_x.get_image(128, 128))
	$Sprite2D.texture = tex


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var ticks: int = Time.get_ticks_msec()
	var stepx: float = noise_gen_x.get_noise_1d(ticks) 
	var stepy: float = noise_gen_y.get_noise_1d(ticks) 
	var step: Vector2 = Vector2(stepx, stepy)
	
	self.global_position += step


func get_noise_gen(_seed: int, octaves: int, freq: float) -> FastNoiseLite:
	var noise_gen = FastNoiseLite.new()
	noise_gen.noise_type = FastNoiseLite.TYPE_PERLIN
	noise_gen.seed = _seed
	noise_gen.fractal_octaves = octaves
	noise_gen.frequency = freq
	return noise_gen
