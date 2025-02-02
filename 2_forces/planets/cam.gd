extends Camera3D

@export var base_speed: float = 25.0
var speed_mod: float = 1.0
@export var look_speed: int = 400
@export var look_smooth: int = 25
var look_scale: float = 0.00001
@export var smooth_scale: float = 0.01
var threshold: float = 0.00001
var target_basis := Basis.IDENTITY


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	if Input.is_action_pressed("cam_turbo"):
		speed_mod = 3.2
	elif Input.is_action_pressed("cam_slow"):
		speed_mod = 0.25
	else:
		speed_mod = 1.0
		
	if Input.is_action_pressed("pm_movebackward"):
		self.translate(Vector3(0,0,1) * delta * base_speed * speed_mod)
	if Input.is_action_pressed("pm_moveforward"):
		self.translate(Vector3(0,0,-1) * delta * base_speed * speed_mod)
	if Input.is_action_pressed("pm_moveleft"):
		self.translate(Vector3(-1,0,0) * delta * base_speed * speed_mod)
	if Input.is_action_pressed("pm_moveright"):
		self.translate(Vector3(1,0,0) * delta * base_speed * speed_mod)
	if Input.is_action_pressed("pm_jump"):
		self.position.y += delta * base_speed * speed_mod
	if Input.is_action_pressed("pm_duck"):
		self.position.y -= delta * base_speed * speed_mod
	
	transform.basis = transform.basis.slerp(target_basis, look_smooth * smooth_scale)


func _input(event: InputEvent) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		if event is InputEventKey:
			if event.is_action_pressed("ui_cancel"):
				get_tree().quit()
	
		if event is InputEventMouseButton:
			if event.button_index == 1:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return
	
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return
	
	if event is InputEventMouseMotion:
		var mouse_direction: Vector2 = -event.relative * look_speed * look_scale
		var distance_to_y: float = (-target_basis.z).angle_to(Vector3.UP * sign(mouse_direction.y))
		mouse_direction.y = clamp(abs(mouse_direction.y), 0.0, distance_to_y - threshold) * sign(mouse_direction.y)
	
		var horz_quat := Quaternion(Vector3.UP * target_basis, mouse_direction.x * 0.80)
		var vert_quat := Quaternion(Vector3.RIGHT, mouse_direction.y)
		
		target_basis *= Basis(horz_quat * vert_quat)
		target_basis = target_basis.orthonormalized()
		transform.basis = target_basis
