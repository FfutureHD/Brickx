extends Label

var Countdown
var Countdownfloat = 0
var Lives
var Points

var CountdownEnded: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	get_parent().get_node("Lost").set_meta("lost", false)
	
	Lives = $Lives.get_meta("Lives")
	$Lives.text = ""
	for n in Lives:
		$Lives.text = String("%s♥️" % $Lives.text)
	
	Points = $Points.get_meta("points")
	$Points.text = tr("Points: %d") % Points
	
	Countdown = get_meta("Countdown")
	
	text = str(Countdown)
	$Lives.position.x = (size.x - $Lives.size.x) / 2
	$Lives.position.y = 0
	$Lives.modulate.a = 0
	$Points.position.x = 0
	$Points.position.y = $Points.size.y
	$Points.position.x = (size.x - $Points.size.x) / 2
	$Points.modulate.a = 0
	
	update_gui(false)
	
	get_parent().get_node("Lost").visible = false
	
	get_parent().get_node("Paused").visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	## Countdown when Game is Paused or restarts:
	if CountdownEnded == true and get_meta("start") == false:
		CountdownEnded = false
		Countdown = get_meta("Countdown")
		$Lives.modulate.a = 0
		$Points.modulate.a = 0
		text = str(Countdown)
	if Countdown >= 0:
		if Countdown>0:
			Countdownfloat +=delta
			if Countdownfloat>=1:
				Countdown -= 1
				Countdownfloat = 0
				text = str(Countdown)
		if Countdown==0:
			if ! CountdownEnded:
				set_meta("start", true)
				CountdownEnded = true
			text = "Start"
			modulate.a -= delta
			if modulate.a<=0:
				Countdown -= 1
				$"Lives".modulate.a = 1
				$Points.modulate.a = 1
				text = ""
				modulate.a = 1
	
	## Update Lives and Points:
	
	if $Lives.get_meta("Lives") != Lives:
		Lives = $Lives.get_meta("Lives")
		if $Lives.get_meta("Lives") >= 0:
			$Lives.text = ""
			for n in Lives:
				$Lives.text = String("%s♥️" % $Lives.text)
			$Lives.position.x = (size.x - $Lives.size.x) / 2
		else:
			lost()
	if $Points.get_meta("points") != Points:
		Points = $Points.get_meta("points")
		$Points.text = tr("Points: %d") % Points
		$Points.position.x = (size.x - $Points.size.x) / 2


func lost() -> void:
	get_tree().paused = true
	get_parent().get_node("Lost/Losttext").text = tr("lost_text") % $Points.get_meta("points")
	get_parent().get_node("Lost").visible = true
	update_gui(true)
	get_parent().get_node("BallTrajectory").hide()
	get_parent().get_node("Countdown").hide()
	get_parent().get_node("Lost").set_meta("lost", true)
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	var save_data = ""
	cfgFile.store_string(save_data)
	cfgFile = null

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://StartMenu.tscn")


func _on_try_again_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Gamerotation.tscn")
	
func update_gui(onlylost: bool) -> void:
	
	if !onlylost:
		get_parent().get_node("Paused").size = get_parent().get_node("Paused/Pausedtext").size + Vector2(20, 20 + get_parent().get_node("Paused/Resume").size.y)
		get_parent().get_node("Paused").position = -get_parent().get_node("Paused").size / 2
		get_parent().get_node("Paused/Pausedtext").position = Vector2(10, 5)
		get_parent().get_node("Paused/Resume").position = Vector2((get_parent().get_node("Paused").size.x - get_parent().get_node("Paused/Resume").size.x) / 2, get_parent().get_node("Paused").size.y - get_parent().get_node("Paused/Resume").size.y - 5)
		
	
	get_parent().get_node("Lost").size = Vector2(max(get_parent().get_node("Lost/Losttext").size.x + 40, get_parent().get_node("Lost/Menu").size.x + 40 + get_parent().get_node("Lost/Try Again").size.x), get_parent().get_node("Lost/Losttext").size.y + 40 + get_parent().get_node("Lost/Menu").size.y)
	get_parent().get_node("Lost/Losttext").position = Vector2((get_parent().get_node("Lost").size.x - get_parent().get_node("Lost/Losttext").size.x) / 2, 10)
	get_parent().get_node("Lost").position = -get_parent().get_node("Lost").size / 2
	get_parent().get_node("Lost/Try Again").position = Vector2(10, get_parent().get_node("Lost").size.y - get_parent().get_node("Lost/Try Again").size.y - 10)
	get_parent().get_node("Lost/Menu").position = Vector2(get_parent().get_node("Lost").size.x - get_parent().get_node("Lost/Menu").size.x - 10, get_parent().get_node("Lost/Try Again").position.y)
	
	
	
