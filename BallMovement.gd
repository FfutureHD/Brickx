extends CharacterBody2D

@export var Lives = 3

@export var countdown = 3
var countdownFloat: float = 0.1
var start = false
@export var movementSpeed: float = 100

@export var ballSize:float = 10.0
var ballScale: float

var collisionBuffer: float = 0.01
var ableToCollide = true

var trajectoryLenght: float
var trajectoryX: float
var trajectoryY: float

var trajectoryAngle: float
var platformAngle: float
var angleOut: float

var winkelAddierung: float = PI / 36

var eingangswinkel
var ausgangswinkel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().position = Vector2(0, 0)
	get_parent().rotation = 0
	position = Vector2(0, 30)
	eingangswinkel = 0
	_changesize(ballSize)
	

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
	
	if countdown > 0:
		if countdown>0:
			countdownFloat += delta
			
			if countdownFloat>=1:
				countdown -= 1
				countdownFloat = 0
	else:
		start = true
	
	if start == true:
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
	
	if sqrt((global_position.x - get_parent().get_parent().position.x) ** 2 + (global_position.y - get_parent().get_parent().position.y) ** 2) >= 200:
		Lives -= 1
		get_parent().get_parent().get_node("Countdown/Lives").text = String("♥️: %d" % Lives)
		_ready()





func _on_plattform_body_entered(body: Node2D) -> void:
	if ableToCollide:
		if body.name == "Ball":
			
			ableToCollide = false
			
			platformAngle = atan2(global_position.y - get_parent().get_parent().position.y, global_position.x - get_parent().get_parent().position.x)
			ausgangswinkel = 2 * platformAngle - eingangswinkel
			while ausgangswinkel >= 2 * PI:
				ausgangswinkel -= 2 * PI
			while ausgangswinkel < 0:
				ausgangswinkel += 2 * PI
			var test = String("eingangswinkel: %0.5f" % eingangswinkel)
			print(test)
			test = String("ausgangswinkel: %0.5f" % ausgangswinkel)
			print(test)
			get_parent().position = global_position - get_parent().get_parent().position
			position = Vector2(0, 0)
			get_parent().rotation = ausgangswinkel
			eingangswinkel = ausgangswinkel
			


func _on_plattform_rechts_body_entered(body: Node2D) -> void:
	if ableToCollide:
		
		ableToCollide = false
		
		if body.name == "Ball":
			
			ableToCollide = false
			
			platformAngle = atan2(global_position.y - get_parent().get_parent().position.y, global_position.x - get_parent().get_parent().position.x)
			ausgangswinkel = (2 * platformAngle - eingangswinkel)  - winkelAddierung
			while ausgangswinkel >= 2 * PI:
				ausgangswinkel -= 2 * PI
			while ausgangswinkel < 0:
				ausgangswinkel += 2 * PI
			var test = String("eingangswinkel: %0.5f" % eingangswinkel)
			print(test)
			test = String("ausgangswinkel: %0.5f" % ausgangswinkel)
			print(test)
			get_parent().position = global_position - get_parent().get_parent().position
			position = Vector2(0, 0)
			get_parent().rotation = ausgangswinkel
			eingangswinkel = ausgangswinkel
			


func _on_plattform_links_body_entered(body: Node2D) -> void:
	if ableToCollide:
		
		ableToCollide = false
		
		if body.name == "Ball":
			
			ableToCollide = false
			
			platformAngle = atan2(global_position.y - get_parent().get_parent().position.y, global_position.x - get_parent().get_parent().position.x)
			ausgangswinkel = (2 * platformAngle - eingangswinkel)  + winkelAddierung
			while ausgangswinkel >= 2 * PI:
				ausgangswinkel -= 2 * PI
			while ausgangswinkel < 0:
				ausgangswinkel += 2 * PI
			var test = String("eingangswinkel: %0.5f" % eingangswinkel)
			print(test)
			test = String("ausgangswinkel: %0.5f" % ausgangswinkel)
			print(test)
			get_parent().position = global_position - get_parent().get_parent().position
			position = Vector2(0, 0)
			get_parent().rotation = ausgangswinkel
			eingangswinkel = ausgangswinkel
			
