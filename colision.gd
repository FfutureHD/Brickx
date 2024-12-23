extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_collision_layer() == 1:
		if get_parent().get_parent().get_parent().get_node("Countdown").get_meta("start"):
			
			set_meta("abpraller", get_meta("abpraller") + 1)
			match (get_meta("hardness") - get_meta("abpraller")):
				0:
					$Area2D/Polygon2D.color = Color(0, 0.95, 1)
				1:
					$Area2D/Polygon2D.color = Color(0, 0.7, 1)
				2:
					$Area2D/Polygon2D.color = Color(0, 0.55, 1)
				3:
					$Area2D/Polygon2D.color = Color(0, 0.05, 1)
					$Area2D/Polygon2D.default_color.a = 0
				4:
					$Area2D/Polygon2D.color = Color(0.4, 0, 1)
					$Area2D/Polygon2D.ddefault_color = Color(0, 0.05, 1, 1)
				5:
					$Area2D/Polygon2D.color = Color(0.7, 0, 1)
					$Area2D/Polygon2D.ddefault_color = Color(0.32, 0, 0.8, 1)
				6:
					$Area2D/Polygon2D.color = Color(1, 0, 1)
					$Area2D/Polygon2D.ddefault_color = Color(0.42, 0, 0.6, 1)
				7:
					$Area2D/Polygon2D.color = Color(1, 0, 0.7)
					$Area2D/Polygon2D.ddefault_color = Color(0.4, 0, 0.4, 1)
				8:
					$Area2D/Polygon2D.color = Color(1, 0, 0.3)
					$Area2D/Polygon2D.ddefault_color = Color(0.2, 0, 0.14, 1)
				9:
					$Area2D/Polygon2D.color = Color(1, 0, 0)
					$Area2D/Polygon2D.ddefault_color = Color(0, 0, 0, 1)
			
			if get_meta("hardness") < get_meta("abpraller"):
				get_parent().get_parent().get_parent().get_node("Countdown/Points").set_meta("points", get_parent().get_parent().get_parent().get_node("Countdown/Points").get_meta("points") + get_meta("abpraller"))
				queue_free()
