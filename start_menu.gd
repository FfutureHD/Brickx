extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Menu.position.x = - $Menu.size.x / 2
	$Menu.position.y = -180
	
	$startGameButton.position.x = -$startGameButton.size.x / 2
	$startGameButton.position.y = -396 / 2 * 0.4
	
	$settingsButton.position.x = -$settingsButton.size.x / 2
	$settingsButton.position.y = 396 / 2 * 0.25
	
	$credits.position.x = -$credits.size.x / 2
	$credits.position.y = 396 / 2 * 0.8
	
	$credits/Window.hide()
	
	$credits/Window.position.x = (396 - $credits/Window.size.x) / 2
	$credits/Window.position.y = (396 - $credits/Window.size.y) / 2
	
	$credits/Window/creditsLabel.position.x = ($credits/Window.size.x - $credits/Window/creditsLabel.size.x) / 2
	$credits/Window/creditsLabel.position.y = ($credits/Window.size.y - $credits/Window/creditsLabel.size.y - 50) / 2
	
	$credits/Window/LinkButton.position = Vector2(($credits/Window.size.x - $credits/Window/LinkButton.size.x)/ 2, 100)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_credits_pressed() -> void:
	$credits/Window.show()


func _on_window_close_requested() -> void:
	$credits/Window.hide()


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Gamerotation.tscn")
