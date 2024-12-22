extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _input(event:InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE):
			##save()
			get_parent().save()
			get_tree().change_scene_to_file("res://StartMenu.tscn")

func pauseGame() -> void:

	get_parent().get_node("Countdown").set_meta("start", false)
	get_parent().save()
	get_parent().get_node("Countdown").hide()
	get_parent().get_node("Paused").visible = true
	
	get_tree().paused = true
	
func _on_resume_pressed() -> void:
	get_tree().paused = false
	get_parent().get_node("Countdown").show()
	get_parent().get_node("Paused").visible = false
	
func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		##save()
		get_parent().save()
		get_tree().change_scene_to_file("res://StartMenu.tscn")
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if ! get_parent().get_node("Lost").get_meta("lost"):
			##save()
			get_parent().save()
		get_tree().quit()
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		# goes to background
		if get_parent().get_node("Lost").visible == false:
			pauseGame()
