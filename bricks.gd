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
	
	var maxlayer: float = 10
	
	minDifficulty = (1-abweichung) * difficulty## - (1-abweichung) / difficulty
	maxDifficulty = (1+abweichung) * difficulty## + (1-abweichung) / difficulty
	randomDifficulty = randf_range(minDifficulty, maxDifficulty)
	
	layerNumber = (round((maxlayer - 1) * (1 - (4 / (randomDifficulty + 4))))) + 1
	brickNumber = Array() ##Array([], TYPE_INT, "", null)
	
	layerHight = 5 * (1 + 1 / layerNumber)

	
	for n in layerNumber:
		
		radius = (layerHight + abstand) * n + 30 + layerHight/2
		brickNumber.append(n + 7)
		set_meta("rotation%d" % n, -1 ** n)
		
		for m in brickNumber[n]:
			circlePosition = m * 2 * PI / brickNumber[n]
			##hier Stein generieren
			var newBrick = loadedBrick.instantiate()
			newBrick.position = Vector2(radius * sin(circlePosition), radius * cos(circlePosition))
			newBrick.rotation = - circlePosition
			get_node("Layer %d" % n).add_child(newBrick)
			##if (randomdifficulty + n * m)
			##position.x = radius * sin(circlePosition)
			##position.y = radius * cos(circlePosition)
			##rotation = rad_to_deg(circleposition) + 90
			##hight = layerHight
			##width = layerHight * 2 * PI / brickNumber[n] - abstand
	
	
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
												set_meta("difficulty", get_meta("difficulty") + 1)
												generateBricks()
		for n in 10:
			get_node("Layer %d" % n).rotation += delta * get_meta("rotation%d" % n)
