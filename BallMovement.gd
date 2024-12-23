extends CharacterBody2D

var movementSpeed: float
var ballSize:float 

var winkelAddierung: float 

var ballScale: float

var trajectoryLenght: float
var trajectoryX: float
var trajectoryY: float

var trajectoryAngle: float
var platformAngle: float
var angleOut: float

var nearPlatform: bool

var eingangswinkel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	winkelAddierung = PI / 360 * get_meta("maxWinkel")
	ballSize = get_meta("ballSize")
	movementSpeed = get_meta("movementSpeed")
	
	get_parent().position = Vector2(0, 0)
	get_parent().rotation = 0
	position = Vector2(0, 100)
	eingangswinkel = get_meta("eingangswinkel")
	nearPlatform = false
	_changesize()
	

func reset() -> void:
	ballSize = get_meta("ballSize")
	movementSpeed = get_meta("movementSpeed")
	get_parent().get_parent().get_node("Countdown").set_meta("start", false)
	get_parent().position = Vector2(0, 0)
	get_parent().rotation = 0
	position = Vector2(0, 100)
	eingangswinkel = 0
	nearPlatform = false
	_changesize()

func _changesize() -> void:
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
	
	
	if (sqrt((global_position.x - get_parent().get_parent().position.x) ** 2 + (global_position.y - get_parent().get_parent().position.y) ** 2) >= 200):
		##TODO check if other Balls are still in the game?
		if get_parent().get_parent().get_node("Countdown/Lives").get_meta("Lives") >= 0:
			get_parent().get_parent().get_node("Countdown/Lives").set_meta("Lives", get_parent().get_parent().get_node("Countdown/Lives").get_meta("Lives") - 1)
		if get_parent().get_parent().get_node("Countdown/Lives").get_meta("Lives") > 0:
			reset()
		


func _on_plattform_body_entered(body: Node2D) -> void:
	if nearPlatform:
		
		if body.get_collision_layer() == 1:
			
			nearPlatform = false
			
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
	if nearPlatform:
		
		if body.get_collision_layer() == 1:
			
			nearPlatform = false
			
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
	if nearPlatform:
		
		if body.get_collision_layer() == 1:
			
			nearPlatform = false
			
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
			

func updateFromSave(trajposx, trajposy, trajrot, posx, posy, size, speed, winkel):
	get_parent().position = Vector2(trajposx, trajposy)
	get_parent().rotation = trajrot
	position = Vector2(posx, posy)
	set_meta("ballSize", size)
	ballSize = size
	set_meta("movementSpeed", speed)
	movementSpeed = speed
	set_meta("eingangswinkel", winkel)
	eingangswinkel = winkel
	


func _on_near_platform_body_entered(body: Node2D) -> void:
	if body.get_collision_layer() == 1:
		nearPlatform = true
