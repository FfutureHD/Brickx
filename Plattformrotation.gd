extends Node2D

var rotaryspeed = 150
var platformSize
var polygonpoints

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	platformSize = get_meta("platformSize")
	
	updateSize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		##save()
		get_parent().save()
		get_tree().change_scene_to_file("res://StartMenu.tscn")
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if ! get_parent().get_node("Lost").get_meta("lost"):
			##save()
			get_parent().save()
		get_tree().quit()
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		# goes to background
		pauseGame()

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			rotation_degrees += rotaryspeed / 20
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			rotation_degrees -= rotaryspeed / 20
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE):
			##save()
			get_parent().save()
			get_tree().change_scene_to_file("res://StartMenu.tscn")

func _physics_process(delta: float) -> void:
	
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees -= rotaryspeed* delta
	
	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees += rotaryspeed* delta
	

func pauseGame() -> void:
	
	get_parent().get_node("Countdown").set_meta("start", false)
	get_parent().save()
	get_parent().get_node("Countdown").hide()
	get_parent().get_node("Paused").visible = true
	
	get_tree().paused = true

func _on_resume_pressed() -> void:
	get_tree().paused = false
	get_parent().get_node("Countdown").show()
	get_parent().get_node("Paused").visible = false

func updateSize() -> void:
	platformSize = get_meta("platformSize")
	polygonpoints = [Vector2(5, 0),Vector2(-5, 0),Vector2(-10, -platformSize),Vector2(-10, 3 - platformSize),Vector2(-5, 3),Vector2(5, 3),Vector2(10, 3 - platformSize),Vector2(10, -platformSize)]
	
	for n in range(0, 8):
		polygonpoints[n] = Vector2(polygonpoints[n].x * platformSize, polygonpoints[n].y)
	$Plattform/Polygon2D.polygon = polygonpoints
	$Plattform/Mitte.shape.extents = Vector2(10 * platformSize/2, 3 + platformSize)
	$"Plattform/Plattform rechts/Rechts".position.x = 7.5 * platformSize
	$"Plattform/Plattform rechts/Rechts".shape.extents = Vector2(5 * platformSize/2, 3 + platformSize)
	$"Plattform/Plattform links/Links".position.x = -7.5 * platformSize
	$"Plattform/Plattform links/Links".shape.extents = Vector2(5 * platformSize/2, 3 + platformSize)
	
