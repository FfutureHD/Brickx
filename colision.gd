extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_collision_layer() == 1:
		if get_parent().get_parent().get_parent().get_node("Countdown").get_meta("start"):
			if get_meta("hardness") > get_meta("abpraller"):
				set_meta("abpraller", get_meta("abpraller") + 1)
			else:
				get_parent().get_parent().get_parent().get_node("Countdown/Points").set_meta("points", get_parent().get_parent().get_parent().get_node("Countdown/Points").get_meta("points") + 1)
				queue_free()
