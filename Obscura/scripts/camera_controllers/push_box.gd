class_name PushBox
extends CameraControllerBase


@export var push_ratio:float = 0.5
@export var pushbox_top_left:Vector2 = Vector2(-9, -9)
@export var pushbox_bottom_right:Vector2 = Vector2(9, 9)
@export var speedup_zone_top_left:Vector2 = Vector2(-4, -4)
@export var speedup_zone_bottom_right:Vector2 = Vector2(4, 4)

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		pass
	
	var tpos = target.global_position
	var cpos = global_position
	
	#boundary checks
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + pushbox_top_left[0])
	#print(diff_between_left_edges)
	
	var speedup_x:bool = false
	var speedup_z:bool = false
	
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
		speedup_z = true
	elif diff_between_left_edges < speedup_zone_bottom_right[0]:
		speedup_x = true 
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x - pushbox_top_left[0])
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
		speedup_z = true
	elif abs(diff_between_right_edges) < speedup_zone_bottom_right[0]:
		speedup_x = true
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + pushbox_top_left[1])
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
		speedup_x = true 
	elif diff_between_top_edges < speedup_zone_bottom_right[1]:
		speedup_z = true
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z - pushbox_top_left[1])
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
		speedup_x = true 
	elif abs(diff_between_bottom_edges) < speedup_zone_bottom_right[1]:
		speedup_z = true
	
	if speedup_x and speedup_z:
		pass
	elif speedup_x:
		global_position.x += target.velocity.x * push_ratio * delta
	elif speedup_z:
		global_position.z += target.velocity.z * push_ratio * delta
	print([diff_between_left_edges, diff_between_right_edges, diff_between_top_edges, diff_between_bottom_edges])
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = pushbox_top_left[0] 
	var right:float = pushbox_bottom_right[0]
	var top:float = pushbox_top_left[1]
	var bottom:float = pushbox_bottom_right[1]
	# draw push zone
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()
	# draw speedup zone
	left = speedup_zone_top_left[0]
	right = speedup_zone_bottom_right[0]
	top = speedup_zone_top_left[1]
	bottom = speedup_zone_bottom_right[1]
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
