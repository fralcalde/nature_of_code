extends MeshInstance3D

const max_width: int = 20
const max_height: int = 20
const max_depth: int = 20

var velocity: Vector3 = Vector3(0, 0, 0)
var speed: int = 25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity.x = randf_range(-1, 1)
	velocity.y = randf_range(-1, 1)
	velocity.z = randf_range(-1, 1)
	velocity = velocity.normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = self.position + velocity * delta * speed
	
	if self.position.x < 0 || max_width < self.position.x:
		velocity.x *= -1
	
	if self.position.y < 0 || max_height < self.position.y:
		velocity.y *= -1 
	
	if self.position.z < 0 || max_depth < self.position.z:
		velocity.z *= -1
	
	
