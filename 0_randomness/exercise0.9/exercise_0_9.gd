extends Node2D

var noise_gen: FastNoiseLite
@export_range(1, 10) var fractal_octaves: int = 5
@export_range(0.00001, 1.0, 0.00001) var freq: float = 0.0001

var image: Image
var curr_img_i: int = 0
var imagetex: NoiseTexture2D

func _ready() -> void:
	noise_gen = get_noise_gen(randi(), fractal_octaves, freq)
	var viewport_size: Vector2 = get_viewport_rect().end
	
	imagetex = NoiseTexture2D.new()
	imagetex.noise = noise_gen
	imagetex.width = viewport_size.x
	imagetex.height = viewport_size.y
	imagetex.in_3d_space = true
	$Sprite2D.texture = imagetex


func get_noise_gen(_seed: int, _octaves: int, _freq: float) -> FastNoiseLite:
	var new_noise_gen = FastNoiseLite.new()
	new_noise_gen.noise_type = FastNoiseLite.TYPE_PERLIN
	new_noise_gen.seed = _seed
	new_noise_gen.fractal_octaves = _octaves
	new_noise_gen.frequency = _freq
	return new_noise_gen


func _process(_delta: float) -> void:
	var tweener = create_tween()
	tweener.tween_property(noise_gen, "offset", noise_gen.offset + Vector3(0, 0, 1), 0.1)



func color_image(img: Image) -> Image:
	var max_x = img.get_width()
	var max_y = img.get_height()
	
	img.convert(Image.FORMAT_RGBA8)
	
	for i in range(max_x):
		for j in range(max_y):
			var pix = img.get_pixel(i, j)
			pix = lerp(Color.BLUE, Color.GREEN, pix.r)
			img.set_pixel(i, j, pix)
	
	return img
