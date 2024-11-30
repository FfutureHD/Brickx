extends Node2D

var buttonFocusTime = 0.5
var buttonFocusCountdown = 0
var content

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Menu.position.x = - $Menu.size.x / 2
	$Menu.position.y = -180
	
	
	$credits.position.x = -$credits.size.x / 2
	$credits.position.y = position.y * 0.8
	$credits.flat = true
	
	$credits/Panel.visible = false
	$credits/Panel.size = $credits/Panel/creditsLabel.size + Vector2(40, $credits/Panel/LinkButton.size.y + $credits/Panel/closeButton.size.y +  40)
	$credits/Panel.global_position = position - $credits/Panel.size / 2
	
	$credits/Panel/closeButton.position.x = ($credits/Panel.size.x - $credits/Panel/closeButton.size.x)
	$credits/Panel/closeButton.position.y = 0
	
	$credits/Panel/Bar.size = Vector2($credits/Panel.size.x, $credits/Panel/closeButton.size.y)
	$credits/Panel/Bar.position = Vector2(0, 0)
	
	$credits/Panel/creditsLabel.position = ($credits/Panel.size - $credits/Panel/creditsLabel.size) / 2
	##$credits/Panel/creditsLabel.position.y = ($credits/Panel.size.y - $credits/Panel/creditsLabel.size.y) / 2
	
	$credits/Panel/LinkButton.position = Vector2(($credits/Panel.size.x - $credits/Panel/LinkButton.size.x)/ 2, $credits/Panel.size.y - $credits/Panel/LinkButton.size.y)
	
	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	content = file.get_as_text()
	
	$"Continue Game".position = -$"Continue Game".size / 2
	
	
	if content == "":
		$startGameButton.position.x = -$startGameButton.size.x / 2
		$startGameButton.position.y = -$startGameButton.size.y / 2 - position.x * 0.2
		
		$settingsButton.position.x = -$settingsButton.size.x / 2
		$settingsButton.position.y = -$settingsButton.size.y / 2 + position.y * 0.2
		
		$"Continue Game".hide()
	else:
		$startGameButton.position.x = -$startGameButton.size.x / 2
		$startGameButton.position.y = -$startGameButton.size.y / 2 - position.x * 0.4
		
		$settingsButton.position.x = -$settingsButton.size.x / 2
		$settingsButton.position.y = -$settingsButton.size.y / 2 + position.y * 0.4
		
		$"Continue Game".show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()

func _input(event:InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
			get_tree().quit()

func _on_credits_pressed() -> void:
	$credits/Panel.show()
	$settingsButton.hide()
	$startGameButton.hide()
	$"Continue Game".hide()

func _on_start_game_button_pressed() -> void:
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	var save_data = ""
	cfgFile.store_string(save_data)
	cfgFile = null
	get_tree().change_scene_to_file("res://Gamerotation.tscn")


func _on_close_button_pressed() -> void:
	$credits/Panel.hide()
	$settingsButton.show()
	$startGameButton.show()
	if content != "":
		$"Continue Game".show()


func _on_continue_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Gamerotation.tscn")
