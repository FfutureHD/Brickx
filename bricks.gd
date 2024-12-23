extends Node2D

var loadedBrick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	loadedBrick = preload("res://Brick.tscn")


func generateBricks() -> void:
	var difficulty = get_meta("difficulty")
	
	var layerNumber: float
	var layerHight: float
	var brickNumber
	
	var radius
	var circlePosition
	var abstand = 2
	
	var abweichung = 0.2
	var maxDifficulty
	var minDifficulty
	var randomDifficulty: float
	
	var brickhardnessfactor: float
	var bricknumberfactor: float
	var brickfactor: float
	
	var adjustvariables: bool = false
	
	var maxlayer: float = 10
	
	minDifficulty = (1-abweichung) * difficulty## - (1-abweichung) / difficulty
	maxDifficulty = (1+abweichung) * difficulty## + (1-abweichung) / difficulty
	randomDifficulty = randf_range(minDifficulty, maxDifficulty)
	
	layerNumber = (round((maxlayer - 1) * (1 - (4 / (randomDifficulty + 4))))) + 1
	brickNumber = Array() ##Array([], TYPE_INT, "", null)
	
	layerHight = 5 * (1 + 1 / layerNumber)
	
	if adjustvariables:
		adjustvariables = false
		match get_meta("difficultySetting"):
			1.0:
				get_parent().get_node("BallTrajectory/Ball").set_meta("movementSpeed", get_parent().get_node("BallTrajectory/Ball").get_meta("movementSpeed") * 1.125)
			2.0:
				get_parent().get_node("BallTrajectory/Ball").set_meta("movementSpeed", get_parent().get_node("BallTrajectory/Ball").get_meta("movementSpeed") * 1.2)
			3.0:
				get_parent().get_node("BallTrajectory/Ball").set_meta("movementSpeed", get_parent().get_node("BallTrajectory/Ball").get_meta("movementSpeed") * 1.2)
			
		
		get_parent().get_node("Plattformrotation").set_meta("platformSize", get_parent().get_node("Plattformrotation").get_meta("platformSize") * 0.9)
		get_parent().get_node("BallTrajectory/Ball").set_meta("ballSize", get_parent().get_node("BallTrajectory/Ball").get_meta("ballSize") * 15 / 16)
	
	brickhardnessfactor = (((difficulty) * (101.0/(get_parent().get_node("BallTrajectory/Ball").get_meta("movementSpeed")+1.0)) * (get_parent().get_node("Plattformrotation").get_meta("platformSize")/5.0) * (get_parent().get_node("BallTrajectory/Ball").get_meta("ballSize") / 16.0)))
	
	for n in layerNumber:
		
		radius = (layerHight + abstand) * n + 30 + layerHight/2
		brickNumber.append(n + 7)
		set_meta("rotation%d" % n, -1 ** n * round_to_dec(randomDifficulty/(randomDifficulty + 50), 1))
		
		for m in brickNumber[n]:
			circlePosition = m * 2 * PI / brickNumber[n]
			##hier Stein generieren
			var newBrick = loadedBrick.instantiate()
			newBrick.position = Vector2(radius * sin(circlePosition), radius * cos(circlePosition))
			newBrick.rotation = - circlePosition
			
			bricknumberfactor = (int(n+m)%4 + 1.0)/4.0
			brickfactor = brickhardnessfactor * bricknumberfactor
			
			if (brickfactor < 2):
				newBrick.set_meta("hardness", 0)
				newBrick.get_node("Area2D/Polygon2D").color = Color(0, 0.95, 1)
			else:
				if (brickfactor < 11):
					match int(brickfactor):
						2:
							newBrick.set_meta("hardness", 1)
							newBrick.get_node("Area2D/Polygon2D").color = Color(0, 0.7, 1)
							newBrick.get_node("Area2D/Line2D").default_color.a = 0
						3:
							newBrick.set_meta("hardness", 2)
							newBrick.get_node("Area2D/Polygon2D").color = Color(0, 0.55, 1)
							newBrick.get_node("Area2D/Line2D").default_color.a = 0
						4:
							newBrick.set_meta("hardness", 3)
							newBrick.get_node("Area2D/Polygon2D").color = Color(0, 0.05, 1)
							newBrick.get_node("Area2D/Line2D").default_color.a = 0
						5:
							newBrick.set_meta("hardness", 4)
							newBrick.get_node("Area2D/Polygon2D").color = Color(0.4, 0, 1)
							newBrick.get_node("Area2D/Line2D").default_color = Color(0, 0.05, 1, 1)
						6:
							newBrick.set_meta("hardness", 5)
							newBrick.get_node("Area2D/Polygon2D").color = Color(0.7, 0, 1)
							newBrick.get_node("Area2D/Line2D").default_color = Color(0.32, 0, 0.8, 1)
						7:
							newBrick.set_meta("hardness", 6)
							newBrick.get_node("Area2D/Polygon2D").color = Color(1, 0, 1)
							newBrick.get_node("Area2D/Line2D").default_color = Color(0.42, 0, 0.6, 1)
						8:
							newBrick.set_meta("hardness", 7)
							newBrick.get_node("Area2D/Polygon2D").color = Color(1, 0, 0.7)
							newBrick.get_node("Area2D/Line2D").default_color = Color(0.4, 0, 0.4, 1)
						9:
							newBrick.set_meta("hardness", 8)
							newBrick.get_node("Area2D/Polygon2D").color = Color(1, 0, 0.3)
							newBrick.get_node("Area2D/Line2D").default_color = Color(0.2, 0, 0.14, 1)
						10:
							newBrick.set_meta("hardness", 9)
							newBrick.get_node("Area2D/Polygon2D").color = Color(1, 0, 0)
							newBrick.get_node("Area2D/Line2D").default_color = Color(0, 0, 1, 1)
				else:
					newBrick.set_meta("hardness", 10)
					newBrick.get_node("Area2D/Polygon2D").color = Color(0, 0, 0)
					newBrick.get_node("Area2D/Line2D").default_color = Color(1, 0, 0, 1)
					adjustvariables = true
			
			get_node("Layer %d" % n).add_child(newBrick)
			

func round_to_dec(num: float, digit: int) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_node("Countdown").get_meta("start"):
		if get_node("Layer 9").get_child_count() == 0:
			if get_node("Layer 8").get_child_count() == 0:
				if get_node("Layer 7").get_child_count() == 0:
					if get_node("Layer 6").get_child_count() == 0:
						if get_node("Layer 5").get_child_count() == 0:
							if get_node("Layer 4").get_child_count() == 0:
								if get_node("Layer 3").get_child_count() == 0:
									if get_node("Layer 2").get_child_count() == 0:
										if get_node("Layer 1").get_child_count() == 0:
											if get_node("Layer 0").get_child_count() == 0:
												set_meta("difficulty", get_meta("difficulty") + get_meta("difficultySetting"))
												get_parent().get_node("BallTrajectory/Ball").reset()
												generateBricks()
		for n in 10:
			get_node("Layer %d" % n).rotation += delta * get_meta("rotation%d" % n)
