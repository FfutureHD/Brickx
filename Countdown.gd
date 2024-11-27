extends Label

@export var Countdown = 3
var Countdownfloat = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Countdown)
	$Lives.position.x = $Lives.size.x / 2
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Countdown >= 0:
		if Countdown>0:
			Countdownfloat +=delta
			if Countdownfloat>=1:
				Countdown -= 1
				Countdownfloat = 0
				text = str(Countdown)
		if Countdown==0:
			text = "Start"
			modulate.a -= delta
			if modulate.a<=0:
				Countdown -= 1
				$"Lives".modulate.a = 1
				text = ""
				modulate.a = 1
				
