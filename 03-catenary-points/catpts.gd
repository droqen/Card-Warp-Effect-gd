@tool
extends Node2D

@export var linelength : float = 500.0
@export var segments : float = 100

# la = length of arc
# wa = width of arch's base
# ha = height of arch
# 

func _physics_process(_delta: float) -> void:
	draw_catenary_bendparam( -$pt1.position.y / 500.0 , linelength )

func draw_catenary_bendparam(bend:float,arc_length:float) -> void:
	var line = $line
	line.clear_points()
	if bend <= 0.0:
		for i in range(-segments,segments+1):
			var x : float = i/segments * arc_length
			line.add_point(Vector2(x+arc_length,0))
	else:
		if bend >= 1.0:
			bend = 1.0
		else:
			bend *= bend
		var a : float = 100.0 / bend
		var base_length = a*asinh(arc_length/a)
		var droop_height = a*cosh(base_length/a)
		for i in range(-segments,segments+1):
			var x : float = i/segments * base_length
			var y : float = a*cosh(x/a)
			line.add_point(Vector2(x+base_length,y-droop_height))
