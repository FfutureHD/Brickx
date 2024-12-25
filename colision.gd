extends Node2D

var brickAngle
var eingangswinkel

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_collision_layer() == 1:
		if get_parent().get_parent().get_parent().get_node("Countdown").get_meta("start"):
			brickdemolish()
			brickbounce(body)
		
	


func brickbounce(ball: Node2D) -> void:
	
	var balldirection: Vector2 = ball.global_position - global_position
	balldirection = balldirection.rotated(-get_parent().rotation)
	balldirection = balldirection.rotated(-rotation)
	
	eingangswinkel = ball.get_meta("eingangswinkel")
	
	brickAngle = atan2(global_position.y - ball.get_parent().get_parent().position.y, global_position.x - ball.get_parent().get_parent().position.x)
	eingangswinkel = 2 * brickAngle - eingangswinkel
	while eingangswinkel >= 2 * PI:
		eingangswinkel -= 2 * PI
	while eingangswinkel < 0:
		eingangswinkel += 2 * PI
	ball.get_parent().position = ball.global_position - ball.get_parent().get_parent().position
	ball.position = Vector2(0, 0)
	
	if balldirection.y == 3.5:
		eingangswinkel = eingangswinkel + PI
	else:
		if (abs(balldirection.x)/abs(balldirection.y-3.5)) > ((15 + abs(ball.get_meta("ballSize")/2))/abs((3.5 + ball.get_meta("ballSize")/2))):
			eingangswinkel = eingangswinkel - PI
		
	
	ball.get_parent().rotation = eingangswinkel
	
	ball.set_meta("eingangswinkel", eingangswinkel)

func brickdemolish() -> void:
	set_meta("abpraller", get_meta("abpraller") + 1)
	get_parent().get_parent().get_parent().get_node("Countdown/Points").set_meta("points", get_parent().get_parent().get_parent().get_node("Countdown/Points").get_meta("points") + 1)
	match (get_meta("hardness") - get_meta("abpraller")):
		0:
			$Area2D/Polygon2D.color = Color(0, 0.95, 1)
		1:
			$Area2D/Polygon2D.color = Color(0, 0.7, 1)
		2:
			$Area2D/Polygon2D.color = Color(0, 0.55, 1)
		3:
			$Area2D/Polygon2D.color = Color(0, 0.05, 1)
			$Area2D/Line2D.default_color.a = 0
		4:
			$Area2D/Polygon2D.color = Color(0.4, 0, 1)
			$Area2D/Line2D.default_color = Color(0, 0.05, 1, 1)
		5:
			$Area2D/Polygon2D.color = Color(0.7, 0, 1)
			$Area2D/Line2D.default_color = Color(0.32, 0, 0.8, 1)
		6:
			$Area2D/Polygon2D.color = Color(1, 0, 1)
			$Area2D/Line2D.default_color = Color(0.42, 0, 0.6, 1)
		7:
			$Area2D/Polygon2D.color = Color(1, 0, 0.7)
			$Area2D/Line2D.default_color = Color(0.4, 0, 0.4, 1)
		8:
			$Area2D/Polygon2D.color = Color(1, 0, 0.3)
			$Area2D/Line2D.default_color = Color(0.2, 0, 0.14, 1)
		9:
			$Area2D/Polygon2D.color = Color(1, 0, 0)
			$Area2D/Line2D.default_color = Color(0, 0, 1, 1)
	
	if get_meta("hardness") < get_meta("abpraller"):
		queue_free()
