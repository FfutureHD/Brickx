extends Node2D

var buttonFocusTime = 0.5
var buttonFocusCountdown = 0
var content
var close = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Settings.hide()
	$credits.flat = true
	$credits/Panel.visible = false
	
	upddate_gui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		if !$credits/Panel.hidden || !$Settings.hidden:
			_on_close_button_pressed()
		else:
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
			get_tree().quit()
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		$Settings.save_settings()
		get_tree().quit()

func _input(event:InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE):
			if !close:
				_on_close_button_pressed()
			else:
				get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
				get_tree().quit()

func _on_credits_pressed() -> void:
	close = false
	$credits.disabled = true
	$credits/Panel.show()
	$settingsButton.hide()
	$startGameButton.hide()
	$"Continue Game".hide()

func _on_start_game_button_pressed() -> void:
	$Settings.save_settings()
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	cfgFile.store_string("")
	cfgFile = null
	var nodeSave = FileAccess.open("user://bricksave.cfg", FileAccess.WRITE)
	nodeSave.store_string("")
	nodeSave = null
	get_tree().change_scene_to_file("res://Gamerotation.tscn")


func _on_close_button_pressed() -> void:
	close = true
	$credits.disabled = false
	$credits/Panel.hide()
	$Settings.hide()
	$settingsButton.show()
	$startGameButton.show()
	if content != "":
		$"Continue Game".show()


func _on_continue_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Gamerotation.tscn")


func _on_settings_button_pressed() -> void:
	close = false
	$credits.disabled = true
	$startGameButton.hide()
	$settingsButton.hide()
	$"Continue Game".hide()
	$Settings.show()

func upddate_gui() -> void:
	$Menu.position.x = - $Menu.size.x / 2
	$Menu.position.y = -180
	
	$credits.position.x = -$credits.size.x / 2
	$credits.position.y = position.y * 0.8
	
	
	
	$credits/Panel/credits.size.y = $credits/Panel/closeButton.size.y
	$credits/Panel.size = $credits/Panel/creditsLabel.size + Vector2(40, $credits/Panel/LinkButton.size.y + $credits/Panel/closeButton.size.y +  40)
	$credits/Panel.global_position = position - $credits/Panel.size / 2
	$credits/Panel/credits.position = Vector2(10, 0)
	$credits/Panel/closeButton.position.x = ($credits/Panel.size.x - $credits/Panel/closeButton.size.x)
	$credits/Panel/closeButton.position.y = 0
	
	$credits/Panel/Bar.size = Vector2($credits/Panel.size.x, $credits/Panel/closeButton.size.y)
	$credits/Panel/Bar.position = Vector2(0, 0)
	
	$credits/Panel/creditsLabel.position = ($credits/Panel.size - $credits/Panel/creditsLabel.size) / 2
	
	$credits/Panel/LinkButton.position = Vector2(($credits/Panel.size.x - $credits/Panel/LinkButton.size.x)/ 2, $credits/Panel.size.y - $credits/Panel/LinkButton.size.y)
	
	
	$Settings/Language/Label.size.y = $Settings/Language/languageButton.size.y
	$Settings/Difficulty/Label.size.y = $Settings/Difficulty/Button.size.y
	$Settings/FPS/Label.size.y = $Settings/FPS/CheckButton.size.y
	$Settings/Settings.size.y = $Settings/closeButton.size.y
	$Settings.size = Vector2(max($Settings/FPS/Label.size.x, $Settings/FPS/CheckButton.size.x, $Settings/Difficulty/Label.size.x, $Settings/Difficulty/Button.size.x, $Settings/Language/Label.size.x, $Settings/Language/languageButton.size.x) + 60, $Settings/Bar.size.y + $Settings/FPS/Label.size.y + $Settings/FPS/CheckButton.size.y + $Settings/Difficulty/Label.size.y + $Settings/Difficulty/Button.size.y + $Settings/Language/languageButton.size.y + 40)
	$Settings.position = - $Settings.size / 2
	$Settings/Settings.position = Vector2(10, 0)
	$Settings/Bar.size = Vector2($Settings.size.x, $Settings/closeButton.size.y)
	$Settings/Bar.position = Vector2(0, 0)
	$Settings/closeButton.position = Vector2($Settings.size.x - $Settings/closeButton.size.x, 0)
	$Settings/Language/Label.position = Vector2(($Settings.size.x - ($Settings/Language/Label.size.x + $Settings/Language/languageButton.size.x + 20)) / 2, 10 + $Settings/Bar.size.y)
	$Settings/Language/languageButton.position = Vector2($Settings/Language/Label.position.x + $Settings/Language/Label.size.x + 20, $Settings/Language/Label.position.y)
	$Settings/Difficulty/Label.position = Vector2(($Settings.size.x - $Settings/Difficulty/Label.size.x) / 2, $Settings/Language/languageButton.position.y + $Settings/Language/languageButton.size.y + 10)
	$Settings/Difficulty/Button.position = Vector2(($Settings.size.x - $Settings/Difficulty/Button.size.x) / 2, $Settings/Difficulty/Label.position.y + $Settings/Difficulty/Label.size.y + 5)
	$Settings/FPS/Label.position = Vector2(($Settings.size.x - $Settings/FPS/Label.size.x) / 2, $Settings/Difficulty/Button.position.y + $Settings/Difficulty/Button.size.y + 10)
	$Settings/FPS/CheckButton.position = Vector2(($Settings.size.x - $Settings/FPS/CheckButton.size.x) / 2, $Settings/FPS/Label.position.y + $Settings/FPS/Label.size.y + 5)
	
	
	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	content = file.get_as_text()
	file = null
	
	$"Continue Game".position = -$"Continue Game".size / 2
	$settingsButton.size.x = max($startGameButton.size.x, $settingsButton.size.x)
	$startGameButton.size.x = $settingsButton.size.x
	
	
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
		
		if close:
			$"Continue Game".show()
