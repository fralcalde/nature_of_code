extends Node3D

var noise_gen: FastNoiseLite


func _ready() -> void:
	noise_gen = get_noise_gen(randi(), 8, 0.001)
	var mesh: Mesh = $MeshInstance3D.mesh
	var mat: ShaderMaterial = mesh.material
	var noise_tex = NoiseTexture2D.new()
	noise_tex.in_3d_space = false
	noise_tex.noise = noise_gen
	noise_tex.height = 256
	noise_tex.width = 256
	noise_tex.normalize = false
	mat.set_shader_parameter("noise", noise_tex)


func _process(delta: float) -> void:
	noise_gen.offset.x += 1
	noise_gen.offset.y += 1


func get_noise_gen(_seed: int, _octaves: int, _freq: float) -> FastNoiseLite:
	var new_noise_gen = FastNoiseLite.new()
	new_noise_gen.noise_type = FastNoiseLite.TYPE_PERLIN
	new_noise_gen.seed = _seed
	new_noise_gen.fractal_octaves = _octaves
	new_noise_gen.frequency = _freq
	return new_noise_gen
