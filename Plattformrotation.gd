extends Node2D

var rotaryspeed = 150
var platformSize
var polygonpoints

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	platformSize = get_meta("platformSize")
	
	updateSize()

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			rotation_degrees += rotaryspeed / 20.0
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			rotation_degrees -= rotaryspeed / 20.0

func _physics_process(delta: float) -> void:
	
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees -= rotaryspeed* delta
	
	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees += rotaryspeed* delta
	

func updateSize() -> void:
	platformSize = get_meta("platformSize")
	polygonpoints = [Vector2(5, 0),Vector2(-5, 0),Vector2(-10, -platformSize),Vector2(-10, 3 - platformSize),Vector2(-5, 3),Vector2(5, 3),Vector2(10, 3 - platformSize),Vector2(10, -platformSize)]
	
	for n in range(0, 8):
		polygonpoints[n] = Vector2(polygonpoints[n].x * platformSize, polygonpoints[n].y)
	$Plattform/Polygon2D.polygon = polygonpoints
	$Plattform/Mitte.shape.extents = Vector2(10 * platformSize/2, platformSize/2 + 3)
	$Plattform/Mitte.position.y = 180 - platformSize/2
	$"Plattform/Plattform rechts/Rechts".position.x = 7.5 * platformSize
	$"Plattform/Plattform rechts/Rechts".shape.extents = Vector2(5 * platformSize/2, platformSize/2 + 3)
	$"Plattform/Plattform rechts/Rechts".position.y = 180 - platformSize/2
	$"Plattform/Plattform links/Links".position.x = -7.5 * platformSize
	$"Plattform/Plattform links/Links".shape.extents = Vector2(5 * platformSize/2, platformSize/2 + 3)
	$"Plattform/Plattform links/Links".position.y = 180 - platformSize/2
	$Plattform/NearPlatform/CollisionShape2D.shape.extents = Vector2(15 * platformSize + 15, 5 * platformSize)
	
