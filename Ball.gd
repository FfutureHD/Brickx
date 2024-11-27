extends Node2D

@export var Countdown = 3
var Countdownfloat
var tempCountdown
var start = false
@export var movementspeed = 100
var sidewayspeed
var linerotation
var lastcollision = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Countdownfloat = Countdown
	linerotation = 0
	sidewayspeed = movementspeed/10
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# starting Countdown
	if Countdown > 0:
		if Countdown>0:
			Countdownfloat -=delta
			tempCountdown = Countdownfloat
			if Countdown-Countdownfloat>=1:
				Countdown -= 1
	else:
		start = true
	
	if start == true:
		
		## everything about ball movement below:
		
		## (x|y) = (radius*cos(drehwinkel)|radius/sin(drehwinkel))
		
		## radius = Wurzel aus (x^2 + y^2)
		## radius = Wurzel aus ( ( x + delta*speed*cos(funktionswinkel) )^2 + ( y + delta*speed*sin(funktionswinkel) )^2 )
		## radius = Wurzel aus ( ( radius*cos(drehwinkel) + delta*speed*cos(funktionswinkel) )^2 + ( radius/sin(drehwinkel) + delta*speed*sin(funktionswinkel) )^2 )
		
		## drehwinkel = arctan( y/x )
		## drehwinkel = arctan( ( y + delta*speed*sin(funktionswinkel) ) / ( x + delta*speed*cos(funktionswinkel) ) )
		## drehwinkel = arctan( ( radius/sin(drehwinkel) + delta*speed*sin(funktionswinkel) ) / ( radius*cos(drehwinkel) + delta*speed*cos(funktionswinkel) ) ) 
		
		$Ball.position.y += delta*movementspeed*cos(linerotation)
		rotation_degrees += delta*sidewayspeed*sin(linerotation)
		
		
	if $Ball/Polygon2D/Collisionradius.is_colliding():
		if !lastcollision:
			linerotation += 10
			lastcollision = true
	else:
		lastcollision = false
	
	
