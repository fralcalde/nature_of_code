@tool
class_name Planet
extends Node3D


var velocity: Vector3 = Vector3.ZERO
var acceleration: Vector3 = Vector3.ZERO
@export var mass: int = 10 : set=set_mass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MeshInstance3D.mesh = SphereMesh.new()
	var mat: StandardMaterial3D = StandardMaterial3D.new()
	mat.set("albedo_color", Color(randf(), randf(), randf()))
	$MeshInstance3D.mesh.material = mat
	set_mass(mass)


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
	var mesh: ImmediateMesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)

	# Start line
	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 0))
	mesh.surface_add_vertex(pos0)

	# End line
	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 0))
	mesh.surface_add_vertex(pos1)

	mesh.surface_end()

	var mesh_node: MeshInstance3D = MeshInstance3D.new()
	mesh_node.mesh = mesh
	get_tree().root.add_child(mesh_node)
	
