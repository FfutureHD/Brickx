extends Node2D

@export var rotaryspeed = 150
var platformSize = 5

var polygonpoints = [Vector2(5, 0),Vector2(-5, 0),Vector2(-10, -platformSize),Vector2(-10, 3 - platformSize),Vector2(-5, 3),Vector2(5, 3),Vector2(10, 3 - platformSize),Vector2(10, -platformSize)]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
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
		get_tree().change_scene_to_file("res://StartMenu.tscn")

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			rotation_degrees += rotaryspeed / 20
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			rotation_degrees -= rotaryspeed / 20
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://StartMenu.tscn")

func _physics_process(delta: float) -> void:
	
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees -= rotaryspeed* delta
	
	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees += rotaryspeed* delta
	
