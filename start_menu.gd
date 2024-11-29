extends Node2D

var buttonFocusTime = 0.5
var buttonFocusCountdown = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Menu.position.x = - $Menu.size.x / 2
	$Menu.position.y = -180
	
	$startGameButton.position.x = -$startGameButton.size.x / 2
	$startGameButton.position.y = -position.x * 0.4
	
	$settingsButton.position.x = -$settingsButton.size.x / 2
	$settingsButton.position.y = position.y * 0.25
	
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
	
	$credits/Panel/creditsLabel.position.x = ($credits/Panel.size.x - $credits/Panel/creditsLabel.size.x) / 2
	$credits/Panel/creditsLabel.position.y = ($credits/Panel.size.y - $credits/Panel/creditsLabel.size.y) / 2
	
	$credits/Panel/LinkButton.position = Vector2(($credits/Panel.size.x - $credits/Panel/LinkButton.size.x)/ 2, $credits/Panel.size.y - $credits/Panel/LinkButton.size.y)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		##TODO hier save funktion aufrufen
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()

func _input(event:InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE):
			##TODO hier save funktion aufrufen
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
			get_tree().quit()

func _on_credits_pressed() -> void:
	$credits/Panel.show()
	$settingsButton.hide()
	$startGameButton.hide()

func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Gamerotation.tscn")


func _on_close_button_pressed() -> void:
	$credits/Panel.hide()
	$settingsButton.show()
	$startGameButton.show()
