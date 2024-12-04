extends Node2D

var abpraller = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if get_parent().get_parent().get_parent().get_node("Countdown").get_meta("start"):
		if abpraller > 0:
			abpraller -= 1
		else:
			get_parent().get_parent().get_parent().get_node("Countdown/Points").set_meta("points", get_parent().get_parent().get_parent().get_node("Countdown/Points").get_meta("points") + 1)
			queue_free()
