class_name HorizontalAutoScrollCamera
extends CameraControllerBase

# y-axis speed has no effect
@export var autoscroll_speed:Vector3 = Vector3(0.5, 0, 0)
@export var top_left:Vector2 = Vector2(-8, -5)
@export var bottom_right:Vector2 = Vector2(8, 5)


func _process(delta: float) -> void:
	if current:
		super(delta)
		# move camera
		position.x += autoscroll_speed[0] * delta
		position.z += autoscroll_speed[2] * delta
		# clamp player to be within the box
		target.position.x = clampf(target.position.x, 
				position.x + top_left[0], 
				position.x +  bottom_right[0])
		target.position.z = clampf(target.position.z, 
				position.z + top_left[1], 
				position.z + bottom_right[1])

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = top_left[0]
	var right:float = bottom_right[0]
	var top:float = top_left[1]
	var bottom:float = bottom_right[1]
	
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
