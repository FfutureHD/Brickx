extends Node2D

var rotaryspeed = 150
var platformSize

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	##load the save file:
	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	var content = file.get_as_text()
	var save = JSON.parse_string(file.get_as_text())
	
	platformSize = get_meta("platformSize")
	
	if content != "":
		platformSize = save.platformSize
		rotation = save.platformrotation
	
	var polygonpoints = [Vector2(5, 0),Vector2(-5, 0),Vector2(-10, -platformSize),Vector2(-10, 3 - platformSize),Vector2(-5, 3),Vector2(5, 3),Vector2(10, 3 - platformSize),Vector2(10, -platformSize)]
	
	for n in range(0, 8):
		polygonpoints[n] = Vector2(polygonpoints[n].x * platformSize, polygonpoints[n].y)
	$Plattform/Polygon2D.polygon = polygonpoints
	$Plattform/Mitte.shape.extents = Vector2(10 * platformSize/2, 3 + platformSize)
	$"Plattform/Plattform rechts/Rechts".position.x = 7.5 * platformSize
	$"Plattform/Plattform rechts/Rechts".shape.extents = Vector2(5 * platformSize/2, 3 + platformSize)
	$"Plattform/Plattform links/Links".position.x = -7.5 * platformSize
	$"Plattform/Plattform links/Links".shape.extents = Vector2(5 * platformSize/2, 3 + platformSize)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		save()
		get_tree().change_scene_to_file("res://StartMenu.tscn")
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if ! get_parent().get_node("Lost").get_meta("lost"):
			save()
		get_tree().quit()
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		# goes to background
		pauseGame()

func save() -> void:
	var save_data = {
		"lives": get_parent().get_node("Countdown/Lives").get_meta("Lives"),
		"points": get_parent().get_node("Countdown/Points").get_meta("points"),
		"trajectoryposition": get_parent().get_node("BallTrajectory").position,
		"trajectoryrotation": get_parent().get_node("BallTrajectory").rotation,
		"ballposition": get_parent().get_node("BallTrajectory/Ball").position,
		"ballsize": get_parent().get_node("BallTrajectory/Ball").get_meta("ballSize"),
		"movementspeed": get_parent().get_node("BallTrajectory/Ball").get_meta("movementSpeed"),
		"eingangswinkel": get_parent().get_node("BallTrajectory/Ball").get_meta("eingangswinkel"),
		"platformSize": platformSize,
		"platformrotation": rotation,
		"lay0rot": get_parent().get_node("Bricks").get_meta("rotation0"),
		"lay1rot": get_parent().get_node("Bricks").get_meta("rotation1"),
		"lay2rot": get_parent().get_node("Bricks").get_meta("rotation2"),
		"lay3rot": get_parent().get_node("Bricks").get_meta("rotation3"),
		"lay4rot": get_parent().get_node("Bricks").get_meta("rotation4"),
		"lay5rot": get_parent().get_node("Bricks").get_meta("rotation5"),
		"lay6rot": get_parent().get_node("Bricks").get_meta("rotation6"),
		"lay7rot": get_parent().get_node("Bricks").get_meta("rotation7"),
		"lay8rot": get_parent().get_node("Bricks").get_meta("rotation8"),
		"lay9rot": get_parent().get_node("Bricks").get_meta("rotation9"),
		"lay0rotdeg": get_parent().get_node("Bricks/Layer 0").rotation,
		"lay1rotdeg": get_parent().get_node("Bricks/Layer 1").rotation,
		"lay2rotdeg": get_parent().get_node("Bricks/Layer 2").rotation,
		"lay3rotdeg": get_parent().get_node("Bricks/Layer 3").rotation,
		"lay4rotdeg": get_parent().get_node("Bricks/Layer 4").rotation,
		"lay5rotdeg": get_parent().get_node("Bricks/Layer 5").rotation,
		"lay6rotdeg": get_parent().get_node("Bricks/Layer 6").rotation,
		"lay7rotdeg": get_parent().get_node("Bricks/Layer 7").rotation,
		"lay8rotdeg": get_parent().get_node("Bricks/Layer 8").rotation,
		"lay9rotdeg": get_parent().get_node("Bricks/Layer 9").rotation
	}
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	cfgFile.store_string(JSON.stringify(save_data))
	cfgFile = null
	
	var nodecfg = FileAccess.open("user://bricksave.cfg", FileAccess.WRITE)
	
	var save_nodes = get_tree().get_nodes_in_group("save")
	for node in save_nodes:
		nodecfg.store_line(JSON.stringify(saveNode(node)))

func saveNode(node: Node):
	var save_dict = {
		"filename" : node.get_scene_file_path(),
		"parent" : node.get_parent().get_path(),
		"pos_x" : node.position.x, # Vector2 is not supported by JSON
		"pos_y" : node.position.y,
		"rotation" : node.rotation
	}
	return save_dict

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			rotation_degrees += rotaryspeed / 20
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			rotation_degrees -= rotaryspeed / 20
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().change_scene_to_file("res://StartMenu.tscn")

func _physics_process(delta: float) -> void:
	
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees -= rotaryspeed* delta
	
	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees += rotaryspeed* delta
	

func pauseGame() -> void:
	
	get_parent().get_node("Countdown").set_meta("start", false)
	save()
	get_parent().get_node("Countdown").hide()
	get_parent().get_node("Paused").visible = true
	
	get_tree().paused = true

func _on_resume_pressed() -> void:
	get_tree().paused = false
	get_parent().get_node("Countdown").show()
	get_parent().get_node("Paused").visible = false
