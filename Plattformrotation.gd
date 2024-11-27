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
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("MWU"):
		rotation_degrees -= delta
		
	if Input.is_action_just_released("MWD"):
		rotation_degrees += rotaryspeed*delta
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		rotation_degrees -= rotaryspeed* delta
		
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees -= rotaryspeed* delta
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN): 
		rotation_degrees += rotaryspeed*delta
		
	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees += rotaryspeed* delta
	
