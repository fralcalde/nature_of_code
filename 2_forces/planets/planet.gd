@tool
class_name Planet
extends Node3D


var velocity: Vector3 = Vector3.ZERO
var acceleration: Vector3 = Vector3.ZERO
@export var mass: int = 10 : set=set_mass
var mat: StandardMaterial3D
var trail: MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MeshInstance3D.mesh = SphereMesh.new()
	mat = StandardMaterial3D.new()
	mat.set("albedo_color", Color(randf(), randf(), randf()))
	$MeshInstance3D.mesh.material = mat
	set_mass(mass)

	trail = MeshInstance3D.new()
	trail.mesh = ImmediateMesh.new()
	get_tree().root.add_child.call_deferred(trail)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	velocity += acceleration

	draw_trail(self.global_position, self.global_position + velocity * delta)

	self.global_position += velocity * delta
	acceleration = Vector3.ZERO


func apply_force(f: Vector3) -> void:
	acceleration += f / mass


func set_velocity(v: Vector3) -> void:
	velocity = v


func set_mass(m: int) -> void:
	mass = m
	
	var sphere_mesh: SphereMesh

	if $MeshInstance3D.mesh and $MeshInstance3D.mesh is SphereMesh:
		sphere_mesh = $MeshInstance3D.mesh
	else:
		sphere_mesh = SphereMesh.new()
		$MeshInstance3D.mesh = sphere_mesh

	var radius: float = 3.0/(4.0 * PI) * mass
	radius = pow(radius, 1/3.0)
	sphere_mesh.radius = radius
	sphere_mesh.height = sphere_mesh.radius * 2


func draw_trail(pos1: Vector3, pos0: Vector3) -> void:
	var mesh = trail.mesh
	var arrays: Array

	if mesh.get_surface_count() > 0:
		arrays = mesh.surface_get_arrays(0)

	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES, mat)

	# Redrawing previous geometry
	if arrays.size() > 0:
		var vertex_data: Array = arrays[0]
		var start: int = max(0, vertex_data.size() - 5000)

		for i in range(start, vertex_data.size(), 2):
			# Start line
			mesh.surface_set_normal(Vector3(0, 0, 1))
			mesh.surface_set_uv(Vector2(0, 0))
			mesh.surface_add_vertex(vertex_data[i])

			# End line
			mesh.surface_set_normal(Vector3(0, 0, 1))
			mesh.surface_set_uv(Vector2(0, 0))
			mesh.surface_add_vertex(vertex_data[i + 1])

	# Start line
	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 0))
	mesh.surface_add_vertex(pos0)

	# End line
	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 0))
	mesh.surface_add_vertex(pos1)

	mesh.surface_end()
