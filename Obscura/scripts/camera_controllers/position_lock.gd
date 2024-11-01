class_name  PositionLockCamera
extends CameraControllerBase

var cross_width = 5
var cross_thickness = 0.2

func _process(delta: float) -> void:
	if current:
		super(delta)
		position.x = target.position.x
		position.z = target.position.z


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	var left:float = -cross_width / 2
	var right:float = cross_width / 2
	var top:float = -cross_width / 2
	var bottom:float = cross_width / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# horizontal line
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	# vertical line
	immediate_mesh.surface_add_vertex(Vector3(0, 0, right))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, left))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
