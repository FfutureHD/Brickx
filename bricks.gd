extends Node2D

var loadedBrick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	loadedBrick = preload("res://Brick.tscn")
	
	var save_file = FileAccess.open("user://save.cfg", FileAccess.READ)
	if save_file.get_as_text() != "":
		var save = JSON.parse_string(save_file.get_as_text())
		
		set_meta("rotation0", save.lay0rot)
		set_meta("rotation1", save.lay1rot)
		set_meta("rotation2", save.lay2rot)
		set_meta("rotation3", save.lay3rot)
		set_meta("rotation4", save.lay4rot)
		set_meta("rotation5", save.lay5rot)
		set_meta("rotation6", save.lay6rot)
		set_meta("rotation7", save.lay7rot)
		set_meta("rotation8", save.lay8rot)
		set_meta("rotation9", save.lay9rot)
		get_node("Layer 0").rotation = save.lay0rotdeg
		get_node("Layer 1").rotation = save.lay1rotdeg
		get_node("Layer 2").rotation = save.lay2rotdeg
		get_node("Layer 3").rotation = save.lay3rotdeg
		get_node("Layer 4").rotation = save.lay4rotdeg
		get_node("Layer 5").rotation = save.lay5rotdeg
		get_node("Layer 6").rotation = save.lay6rotdeg
		get_node("Layer 7").rotation = save.lay7rotdeg
		get_node("Layer 8").rotation = save.lay8rotdeg
		get_node("Layer 9").rotation = save.lay9rotdeg
		
		
		save_file = FileAccess.open("user://bricksave.cfg", FileAccess.READ)
		
		if save_file.get_as_text() != "":
			var save_nodes = get_tree().get_nodes_in_group("save")
			for i in save_nodes:
				i.queue_free()
			
			while save_file.get_position() < save_file.get_length():
				var json_string = save_file.get_line()
				var json = JSON.new()
				var parse_result = json.parse(json_string)
				if not parse_result == OK:
					print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
					continue
				var node_data = json.data
				var new_object = load(node_data["filename"]).instantiate()
				var newBrick = loadedBrick.instantiate()
				newBrick.position = Vector2(node_data["pos_x"], node_data["pos_y"])
				newBrick.rotation = node_data["rotation"]
				get_node(node_data["parent"]).add_child(newBrick)
		else:
			generateBricks(get_meta("difficulty"))
	else:
		generateBricks(get_meta("difficulty"))


func generateBricks(difficulty: float) -> void:
	
	var layerNumber: float
	var layerHight: int
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
	
	layerNumber = ((maxlayer - 1) * (1 - (2 / (randomDifficulty + 1)))) + 1
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
												generateBricks(get_meta("difficulty"))
		for n in 10:
			get_node("Layer %d" % n).rotation += delta * get_meta("rotation%d" % n)
