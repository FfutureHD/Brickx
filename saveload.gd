extends Node2D

var saveFile
var content
var saveData
var settings
var brickData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	##write both save files to variables:
	
	saveFile = FileAccess.open("user://save.cfg", FileAccess.READ)
	content = saveFile.get_as_text()
	saveData = JSON.parse_string(content)
	saveFile = FileAccess.open("user://settings.cfg", FileAccess.READ)
	settings = JSON.parse_string(saveFile.get_as_text())
	saveFile = FileAccess.open("user://bricksave.cfg", FileAccess.READ)
	
	if content != "":
		loadBricks(saveFile, saveData)
		saveFile = null
		_load(saveData)
	else:
		$Bricks.set_meta("difficultySetting", settings.difficulty)
		$Bricks.set_meta("difficulty", settings.difficulty)
		$Bricks.generateBricks()
		saveFile = null
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func save() -> void:
	
	##normal save file:
	
	var save_data = {
		"lives": $Countdown/Lives.get_meta("Lives"),
		"points": $Countdown/Points.get_meta("points"),
		"trajectorypositionx": $BallTrajectory.position.x,
		"trajectorypositiony": $BallTrajectory.position.y,
		"trajectoryrotation": $BallTrajectory.rotation,
		"ballpositionx": $BallTrajectory/Ball.position.x,
		"ballpositiony": $BallTrajectory/Ball.position.y,
		"ballsize": $BallTrajectory/Ball.get_meta("ballSize"),
		"movementspeed": $BallTrajectory/Ball.get_meta("movementSpeed"),
		"eingangswinkel": $BallTrajectory/Ball.get_meta("eingangswinkel"),
		"platformsize": $Plattformrotation.get_meta("platformSize"),
		"platformrotation": $Plattformrotation.rotation,
		"difficulty": $Bricks.get_meta("difficulty"),
		"lay0rot": $Bricks.get_meta("rotation0"),
		"lay1rot": $Bricks.get_meta("rotation1"),
		"lay2rot": $Bricks.get_meta("rotation2"),
		"lay3rot": $Bricks.get_meta("rotation3"),
		"lay4rot": $Bricks.get_meta("rotation4"),
		"lay5rot": $Bricks.get_meta("rotation5"),
		"lay6rot": $Bricks.get_meta("rotation6"),
		"lay7rot": $Bricks.get_meta("rotation7"),
		"lay8rot": $Bricks.get_meta("rotation8"),
		"lay9rot": $Bricks.get_meta("rotation9"),
		"lay0rotdeg": $"Bricks/Layer 0".rotation,
		"lay1rotdeg": $"Bricks/Layer 1".rotation,
		"lay2rotdeg": $"Bricks/Layer 2".rotation,
		"lay3rotdeg": $"Bricks/Layer 3".rotation,
		"lay4rotdeg": $"Bricks/Layer 4".rotation,
		"lay5rotdeg": $"Bricks/Layer 5".rotation,
		"lay6rotdeg": $"Bricks/Layer 6".rotation,
		"lay7rotdeg": $"Bricks/Layer 7".rotation,
		"lay8rotdeg": $"Bricks/Layer 8".rotation,
		"lay9rotdeg": $"Bricks/Layer 9".rotation
	}
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	cfgFile.store_string(JSON.stringify(save_data))
	cfgFile = null
	
	##brick save file:
	
	var nodecfg = FileAccess.open("user://bricksave.cfg", FileAccess.WRITE)
	
	var save_nodes = get_tree().get_nodes_in_group("save")
	for node in save_nodes:
		nodecfg.store_line(JSON.stringify(saveNode(node)))

func saveNode(node: Node):
	var save_dict = {
		"filename" : node.get_scene_file_path(),
		"parent" : node.get_parent().get_path(),
		"pos_x" : node.position.x, # Vector2 is not supported by JSON
		"pos_y" : node.position.y,
		"rotation" : node.rotation
	}
	return save_dict

func _load(data) -> void:
	$Countdown/Lives.set_meta("Lives", data.lives)
	$Countdown/Points.set_meta("points", data.points)
	$BallTrajectory/Ball.updateFromSave(data.trajectorypositionx, data.trajectorypositiony, data.trajectoryrotation, data.ballpositionx, data.ballpositiony, data.ballsize, data.movementspeed, data.eingangswinkel)
	$Plattformrotation.set_meta("platformSize", data.platformsize)
	$Plattformrotation.rotation = data.platformrotation

func loadBricks(brickdata, savedata) -> void:
	
	var loadedBrick = preload("res://Brick.tscn")
	
	var save_nodes = get_tree().get_nodes_in_group("save")
	for i in save_nodes:
		i.queue_free()
	
	while brickdata.get_position() < brickdata.get_length():
				var json_string = brickdata.get_line()
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
	
	$Bricks.set_meta("rotation0", savedata.lay0rot)
	$Bricks.set_meta("rotation1", savedata.lay1rot)
	$Bricks.set_meta("rotation2", savedata.lay2rot)
	$Bricks.set_meta("rotation3", savedata.lay3rot)
	$Bricks.set_meta("rotation4", savedata.lay4rot)
	$Bricks.set_meta("rotation5", savedata.lay5rot)
	$Bricks.set_meta("rotation6", savedata.lay6rot)
	$Bricks.set_meta("rotation7", savedata.lay7rot)
	$Bricks.set_meta("rotation8", savedata.lay8rot)
	$Bricks.set_meta("rotation9", savedata.lay9rot)
	$"Bricks/Layer 0".rotation = savedata.lay0rotdeg
	$"Bricks/Layer 1".rotation = savedata.lay1rotdeg
	$"Bricks/Layer 2".rotation = savedata.lay2rotdeg
	$"Bricks/Layer 3".rotation = savedata.lay3rotdeg
	$"Bricks/Layer 4".rotation = savedata.lay4rotdeg
	$"Bricks/Layer 5".rotation = savedata.lay5rotdeg
	$"Bricks/Layer 6".rotation = savedata.lay6rotdeg
	$"Bricks/Layer 7".rotation = savedata.lay7rotdeg
	$"Bricks/Layer 8".rotation = savedata.lay8rotdeg
	$"Bricks/Layer 9".rotation = savedata.lay9rotdeg
	
