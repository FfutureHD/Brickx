extends CharacterBody2D

var countdownFloat: float = 0.5
var movementSpeed: float
var ballSize:float 

var winkelAddierung: float 

var ballScale: float

var collisionBuffer: float = 0.01
var ableToCollide = true

var trajectoryLenght: float
var trajectoryX: float
var trajectoryY: float

var trajectoryAngle: float
var platformAngle: float
var angleOut: float


var eingangswinkel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	##loads save file:
	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	var content = file.get_as_text()
	var save = JSON.parse_string(file.get_as_text())
	
	
	winkelAddierung = PI / 360 * get_meta("maxWinkel")
	ballSize = get_meta("ballSize")
	movementSpeed = get_meta("movementSpeed")
	
	get_parent().position = Vector2(0, 0)
	get_parent().rotation = 0
	position = Vector2(0, 100)
	eingangswinkel = get_meta("eingangswinkel")
	
	if content != "":
		ballSize = save.ballsize
		movementSpeed = save.movementspeed
		eingangswinkel = save.eingangswinkel
		get_parent().position = string_to_vector2(save.trajectoryposition)
		get_parent().rotation = save.trajectoryrotation
		position = string_to_vector2(save.ballposition)
	
	_changesize(ballSize)
	
	

static func string_to_vector2(string := "") -> Vector2:
	if string:
		var new_string: String = string
		new_string = new_string.erase(0, 1)
		new_string = new_string.erase(new_string.length() - 1, 1)
		var array: Array = new_string.split(", ")

		return Vector2(int(array[0]), int(array[1]))

	return Vector2.ZERO

func reset() -> void:
	ballSize = get_meta("ballSize")
	movementSpeed = get_meta("movementSpeed")
	get_parent().position = Vector2(0, 0)
	get_parent().rotation = 0
	position = Vector2(0, 30)
	eingangswinkel = 0
	_changesize(get_meta("ballSize"))

func _changesize(ballSize: float) -> void:
	## sets the right sprite and radius for the ballSize
	
	$CollisionShape2D.shape.radius = ballSize / 2 + 1
	
	if ballSize <= 4:
		$BallSprite.texture = load("res://textures/Ball/ball_4x.png")
		ballScale = ballSize / 4
		$BallSprite.scale = Vector2(ballScale, ballScale)
	else:
		if ballSize <= 6:
			$BallSprite.texture = load("res://textures/Ball/ball_6x.png")
			ballScale = ballSize / 6
			$BallSprite.scale = Vector2(ballScale, ballScale)
		else:
			if ballSize <= 8:
				$BallSprite.texture = load("res://textures/Ball/ball_8x.png")
				ballScale = ballSize / 8
				$BallSprite.scale = Vector2(ballScale, ballScale)
			else:
				if ballSize <= 12:
					$BallSprite.texture = load("res://textures/Ball/ball_12x.png")
					ballScale = ballSize / 12
					$BallSprite.scale = Vector2(ballScale, ballScale)
				else:
					if ballSize <= 32:
						$BallSprite.texture = load("res://textures/Ball/ball_32x.png")
						ballScale = ballSize / 32
						$BallSprite.scale = Vector2(ballScale, ballScale)
					else:
						if ballSize <= 64:
							$BallSprite.texture = load("res://textures/Ball/ball_64x.png")
							ballScale = ballSize / 64
							$BallSprite.scale = Vector2(ballScale, ballScale)
						else:
							if ballSize > 64:
								$BallSprite.texture = load("res://textures/Ball/ball_128x.png")
								ballScale = ballSize / 128
								$BallSprite.scale = Vector2(ballScale, ballScale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if get_parent().get_parent().get_node("Countdown").get_meta("start") == true:
		trajectoryX = get_parent().get_point_position(1).x - position.x
		trajectoryY = get_parent().get_point_position(1).y - position.y
		trajectoryLenght = sqrt(trajectoryX ** 2 + trajectoryY ** 2)
		
		position.x += ((trajectoryX / trajectoryLenght) * delta * movementSpeed)
		position.y += ((trajectoryY / trajectoryLenght) * delta * movementSpeed)
	
	if ! ableToCollide:
		countdownFloat += delta
		if countdownFloat >= collisionBuffer:
			ableToCollide = true
			countdownFloat = 0
	
	if (sqrt((global_position.x - get_parent().get_parent().position.x) ** 2 + (global_position.y - get_parent().get_parent().position.y) ** 2) >= 200):
		##TODO check if other Balls are still in the game?
		if get_parent().get_parent().get_node("Countdown/Lives").get_meta("Lives") >= 0:
			get_parent().get_parent().get_node("Countdown/Lives").set_meta("Lives", get_parent().get_parent().get_node("Countdown/Lives").get_meta("Lives") - 1)
		if get_parent().get_parent().get_node("Countdown/Lives").get_meta("Lives") > 0:
			reset()
		


func _on_plattform_body_entered(body: Node2D) -> void:
	if ableToCollide:
		if body.name == "Ball":
			
			ableToCollide = false
			
			platformAngle = atan2(global_position.y - get_parent().get_parent().position.y, global_position.x - get_parent().get_parent().position.x)
			eingangswinkel = 2 * platformAngle - eingangswinkel
			while eingangswinkel >= 2 * PI:
				eingangswinkel -= 2 * PI
			while eingangswinkel < 0:
				eingangswinkel += 2 * PI
			get_parent().position = global_position - get_parent().get_parent().position
			position = Vector2(0, 0)
			get_parent().rotation = eingangswinkel
			set_meta("eingangswinkel", eingangswinkel)
			


func _on_plattform_rechts_body_entered(body: Node2D) -> void:
	if ableToCollide:
		
		ableToCollide = false
		
		if body.name == "Ball":
			
			ableToCollide = false
			
			platformAngle = atan2(global_position.y - get_parent().get_parent().position.y, global_position.x - get_parent().get_parent().position.x)
			eingangswinkel = (2 * platformAngle - eingangswinkel)  - winkelAddierung
			while eingangswinkel >= 2 * PI:
				eingangswinkel -= 2 * PI
			while eingangswinkel < 0:
				eingangswinkel += 2 * PI
			get_parent().position = global_position - get_parent().get_parent().position
			position = Vector2(0, 0)
			get_parent().rotation = eingangswinkel
			set_meta("eingangswinkel", eingangswinkel)
			


func _on_plattform_links_body_entered(body: Node2D) -> void:
	if ableToCollide:
		
		ableToCollide = false
		
		if body.name == "Ball":
			
			ableToCollide = false
			
			platformAngle = atan2(global_position.y - get_parent().get_parent().position.y, global_position.x - get_parent().get_parent().position.x)
			eingangswinkel = (2 * platformAngle - eingangswinkel)  + winkelAddierung
			while eingangswinkel >= 2 * PI:
				eingangswinkel -= 2 * PI
			while eingangswinkel < 0:
				eingangswinkel += 2 * PI
			get_parent().position = global_position - get_parent().get_parent().position
			position = Vector2(0, 0)
			get_parent().rotation = eingangswinkel
			set_meta("eingangswinkel", eingangswinkel)
			
