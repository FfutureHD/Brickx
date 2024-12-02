extends Label

@export var Countdown = 3
var Countdownfloat = 0
var Lives

var CoutdownEnded: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	##load the save file:
	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	var content = file.get_as_text()
	var save = JSON.parse_string(file.get_as_text())
	
	if content != "":
		$Lives.set_meta("Lives", save.lives)
		$Points.set_meta("points", save.points)
	
	get_parent().get_node("Lost").set_meta("lost", false)
	
	Lives = $Lives.get_meta("Lives")
	$Lives.text = ""
	for n in Lives:
		$Lives.text = String("%s♥️" % $Lives.text)
	
	text = str(Countdown)
	$Lives.position.x = $Lives.size.x / 2
	$Lives.position.y = 0
	$Lives.modulate.a = 0
	$Points.position.x = 0
	$Points.position.y = $Points.size.y
	$Points.modulate.a = 0
	
	get_parent().get_node("Lost").visible = false
	get_parent().get_node("Lost").size = get_parent().get_node("Lost/Losttext").size + Vector2(40, 40 + get_parent().get_node("Lost/Menu").size.y)
	get_parent().get_node("Lost/Losttext").position = Vector2(20, 10)
	get_parent().get_node("Lost").position = -get_parent().get_node("Lost").size / 2
	get_parent().get_node("Lost/Try Again").position = Vector2(10, get_parent().get_node("Lost").size.y - get_parent().get_node("Lost/Try Again").size.y - 10)
	get_parent().get_node("Lost/Menu").position = Vector2(get_parent().get_node("Lost").size.x - get_parent().get_node("Lost/Menu").size.x - 10, get_parent().get_node("Lost").size.y - get_parent().get_node("Lost/Menu").size.y - 10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Countdown >= 0:
		if Countdown>0:
			Countdownfloat +=delta
			if Countdownfloat>=1:
				Countdown -= 1
				Countdownfloat = 0
				text = str(Countdown)
		if Countdown==0:
			if ! CoutdownEnded:
				set_meta("start", true)
				CoutdownEnded = true
			text = "Start"
			modulate.a -= delta
			if modulate.a<=0:
				Countdown -= 1
				$"Lives".modulate.a = 1
				$Points.modulate.a = 1
				text = ""
				modulate.a = 1
				
	if $Lives.get_meta("Lives") != Lives:
		Lives = $Lives.get_meta("Lives")
		if $Lives.get_meta("Lives") >= 0:
			$Lives.text = ""
			for n in Lives:
				$Lives.text = String("%s♥️" % $Lives.text)
			$Lives.position.x = $Lives.size.x / 2
		else:
			lost()

func lost() -> void:
	get_parent().get_node("Lost/Losttext").text = String("""Oh no
	you've lost
	you got %s points""" % $Points.get_meta("points"))
	get_parent().get_node("Lost").size = get_parent().get_node("Lost/Losttext").size + Vector2(40, 40 + get_parent().get_node("Lost/Menu").size.y)
	get_parent().get_node("Lost/Losttext").position = Vector2(20, 10)
	get_parent().get_node("Lost").position = -get_parent().get_node("Lost").size / 2
	get_parent().get_node("Lost").visible = true
	get_parent().get_node("BallTrajectory").hide()
	get_parent().get_node("Countdown").hide()
	get_parent().get_node("Lost").set_meta("lost", true)
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	var save_data = ""
	cfgFile.store_string(save_data)
	cfgFile = null


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://StartMenu.tscn")


func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Gamerotation.tscn")
