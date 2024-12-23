extends Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	## if there is no save file, one will be created:
	if not FileAccess.file_exists("user://settings.cfg"):
		var defaultSettings = {
			"fps": 60,
			"difficulty": 1,
			"language": 1
		}
		var defset = FileAccess.open("user://settings.cfg", FileAccess.WRITE)
		defset.store_string(JSON.stringify(defaultSettings))
		
	var settFile = FileAccess.open("user://settings.cfg", FileAccess.READ)
	var settings = JSON.parse_string(settFile.get_as_text())
	Engine.max_fps = settings.fps
	if settings.fps == 60:
		$FPS/CheckButton.text = "60 FPS"
		$FPS/CheckButton.button_pressed = true
	else:
		$FPS/CheckButton.text = "30 FPS"
		$FPS/CheckButton.button_pressed = false
	match settings.difficulty:
		1.0:
			set_meta("difficultySetting", 1)
			$Difficulty/Button.text = "Beginner"
			$Difficulty/Button.modulate = Color(0, 200, 0)
		2.0:
			set_meta("difficultySetting", 2)
			$Difficulty/Button.text = "Medium"
			$Difficulty/Button.modulate = Color(255, 200, 0)
		3.0:
			set_meta("difficultySetting", 3)
			$Difficulty/Button.text = "Extreme"
			$Difficulty/Button.modulate = Color(200, 0, 0)
		
	
	match settings.language:
		1.0:
			set_meta("Language", 1)
			TranslationServer.set_locale("en")
			$Language/languageButton.text = "English"
		2.0:
			set_meta("Language", 2)
			TranslationServer.set_locale("de")
			$Language/languageButton.text = "German"
		3.0:
			set_meta("Language", 3)
			TranslationServer.set_locale("fr")
			$Language/languageButton.text = "French"
		4.0:
			set_meta("Language", 4)
			TranslationServer.set_locale("es")
			$Language/languageButton.text = "Spanish"
		5.0:
			set_meta("Language", 5)
			TranslationServer.set_locale("nl")
			$Language/languageButton.text = "Dutch"
		6.0:
			set_meta("Language", 6)
			TranslationServer.set_locale("it")
			$Language/languageButton.text = "Italian"
		7.0:
			set_meta("Language", 7)
			TranslationServer.set_locale("ja")
			$Language/languageButton.text = "Japanese"
		8.0:
			set_meta("Language", 8)
			TranslationServer.set_locale("se")
			$Language/languageButton.text = "Swedish"

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$FPS/CheckButton.text = "60 FPS"
		Engine.max_fps = 60
	else:
		$FPS/CheckButton.text = "30 FPS"
		Engine.max_fps = 30


func _on_button_pressed() -> void:
	match get_meta("Difficulty"):
		1:
			$Difficulty/Button.modulate = Color(255, 200, 0)
			set_meta("difficultySetting", 2)
			$Difficulty/Button.text = "Medium"
		2:
			$Difficulty/Button.modulate = Color(200, 0, 0)
			set_meta("difficultySetting", 3)
			$Difficulty/Button.text = "Extreme"
		3:
			$Difficulty/Button.modulate = Color(0, 200, 0)
			set_meta("difficultySetting", 1)
			$Difficulty/Button.text = "Beginner"
	
	$Difficulty/Button.reset_size()
	$Difficulty/Button.position = Vector2((size.x - $Difficulty/Button.size.x) / 2, $Difficulty/Label.position.y + $Difficulty/Label.size.y + 5)


func save_settings() -> void:
	var settings = {
			"fps": Engine.max_fps,
			"difficulty": get_meta("Difficulty"),
			"language": get_meta("Language")
	}
	var settFile = FileAccess.open("user://settings.cfg", FileAccess.WRITE)
	settFile.store_string(JSON.stringify(settings))
	settFile = null


func _on_language_button_pressed() -> void:
	
	match get_meta("Language"):
		1:
			set_meta("Language", 2)
			TranslationServer.set_locale("de")
			$Language/languageButton.text = "German"
		2:
			set_meta("Language", 3)
			TranslationServer.set_locale("fr")
			$Language/languageButton.text = "French"
		3:
			set_meta("Language", 4)
			TranslationServer.set_locale("es")
			$Language/languageButton.text = "Spanish"
		4:
			set_meta("Language", 5)
			TranslationServer.set_locale("nl")
			$Language/languageButton.text = "Dutch"
		5:
			set_meta("Language", 6)
			TranslationServer.set_locale("it")
			$Language/languageButton.text = "Italian"
		6:
			set_meta("Language", 7)
			TranslationServer.set_locale("ja")
			$Language/languageButton.text = "Japanese"
		7:
			set_meta("Language", 8)
			TranslationServer.set_locale("se")
			$Language/languageButton.text = "Swedish"
		8:
			set_meta("Language", 1)
			TranslationServer.set_locale("en")
			$Language/languageButton.text = "English"
	await get_tree().create_timer(0.001).timeout
	get_parent().upddate_gui()
	
	
