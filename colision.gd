extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_collision_layer() == 1:
		if get_parent().get_parent().get_parent().get_node("Countdown").get_meta("start"):
			
			set_meta("abpraller", get_meta("abpraller") + 1)
			$Area2D/Polygon2D.color -= $Area2D/Polygon2D.color / (get_meta("hardness") + 1)
			
			if get_meta("hardness") < get_meta("abpraller"):
				get_parent().get_parent().get_parent().get_node("Countdown/Points").set_meta("points", get_parent().get_parent().get_parent().get_node("Countdown/Points").get_meta("points") + get_meta("abpraller"))
				queue_free()
