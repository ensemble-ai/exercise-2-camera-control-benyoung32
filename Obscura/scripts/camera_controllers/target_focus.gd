class_name TargetFocusCamera
extends CameraControllerBase
# ratio of leading speed versus vessel speed
# e.g. lead_speed = 1.25 -> the camera will move 1.25x faster than the target 
@export var lead_speed:float = 1.25
# how long the camera stays in place until it returns to the target
@export var catchup_delay_duration:float = 1.5
# how fast camera moves when target is not moving
@export var catchup_speed:float = 30
# max distance between camera and target
@export var leash_distance:float = 5
var cross_width:float = 5
var time_since_moved:float = 0

func _process(delta: float) -> void:
	# unit vector pointing towards target
	var towards_target:Vector3 = position.direction_to(target.position)
	var dist = position.distance_to(target.position)
	# follow or catchup to target
	if target.velocity.length() > 0:
		time_since_moved = clampf(time_since_moved - delta * 3, 0, catchup_delay_duration)
		position = position + target.velocity * lead_speed * delta
	else:
		time_since_moved += delta
		if time_since_moved > catchup_delay_duration:
			if dist < 0.5:
				# snap to target when nearby to prevent stuttering
				position = target.position
			else:
				# else move towards target at catchup rate
				position = position + towards_target * catchup_speed * delta
	
	# check if we are too far away on the x and z axes
	var old_y = position.y
	position.y = target.position.y
	dist = position.distance_to(target.position)
	if dist > leash_distance:
		position = target.position + target.position.direction_to(position) * leash_distance
	position.y = old_y
	
	super(delta)


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
