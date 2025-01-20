@tool
extends Node2D

@export var linelength : float = 500.0
@export var segments : float = 100

func _physics_process(_delta: float) -> void:
	draw_catenary($pt1.position.y,linelength)

func draw_catenary(a:float,lengthofROPE:float) -> void:
	var line = $line
	line.clear_points()
	var lengthofSHADOW = a*asinh(lengthofROPE/a)
	var heightofDROOP = a*cosh(lengthofSHADOW/a)
	for i in range(-segments,segments+1):
		var x : float = i/segments * lengthofSHADOW
		var y : float = a*cosh(x/a)
		line.add_point(Vector2(x,y-heightofDROOP))
	
