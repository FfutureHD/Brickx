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
		"platformrotation": rotation
	}
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	cfgFile.store_string(JSON.stringify(save_data))
	cfgFile = null

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
	
