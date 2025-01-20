@tool
extends Node2D

@export var linelength : float = 500.0
@export var segments : float = 100

# la = length of arc
# wa = width of arch's base
# ha = height of arch
# 

func _physics_process(_delta: float) -> void:
	draw_catenary_inva(-$pt1.position.y * 0.00001,linelength)
	#draw_catenary_from_droopheight(500.0, $pt1.position.x/2, 1000.0/$pt1.position.x)
	#draw_catenary_from_droopheight(linelength,$pt1.position.y)

func draw_catenary(a:float,arc_length:float) -> void:
	var line = $line
	line.clear_points()
	var base_length = a*asinh(arc_length/a)
	var droop_height = a*cosh(base_length/a)
	for i in range(-segments,segments+1):
		var x : float = i/segments * base_length
		var y : float = a*cosh(x/a)
		line.add_point(Vector2(x+base_length,y-droop_height))

func draw_catenary_inva(inva:float,arc_length:float) -> void:
	var line = $line
	line.clear_points()
	var a : float = 1.0/inva
	var base_length = a*asinh(arc_length/a)
	var droop_height = a*cosh(base_length/a)
	for i in range(-segments,segments+1):
		var x : float = i/segments * base_length
		var y : float = a*cosh(x/a)
		line.add_point(Vector2(x+base_length,y-droop_height))
	
func draw_catenary_from_compressedlength(arc_length:float,base_length:float) -> void:
	if base_length > arc_length: base_length = arc_length
	var line = $line
	line.clear_points()
	var afrag : float = 0.5
	var a : float = arc_length * afrag
	var astep : float = 0.25
	for iter in range(10):
		var best_a2 = a
		var best_a2_arc_length = null
		for a2 in [a-astep,a,a+astep]:
			var droop_height = a2*cosh(base_length/a2)
			for i in range(-segments,segments+1):
				var x : float = i/segments * base_length
				var y : float = a*cosh(x/a)
				line.add_point(Vector2(x+base_length,y-droop_height))
	
func draw_catenary_from_droopheight(arc_length:float, droop_height:float) -> void:
	var line = $line
	line.clear_points()
	var a = sqrt( droop_height*droop_height - arc_length*arc_length )
	var base_length = a*acosh(droop_height/a)
	#var a = a*asinh(arc_length/a)
	var arch_height : float = a - droop_height
	prints(droop_height, arc_length, a, arch_height)
	
	for i in range(-segments,segments+1):
		var x : float = i/segments * base_length
		var y : float = a*cosh(x/a)
		line.add_point(Vector2(x+base_length,y-droop_height))

#func draw_catenary_from_archheight(arc_length:float, arch_height:float) -> void:
	#var line = $line
	#line.clear_points()
	#var a = sqrt( droop_height*droop_height - arc_length*arc_length )
	#var base_length = a*acosh(droop_height/a)
	##var a = a*asinh(arc_length/a)
	#var arch_height : float = a - droop_height
	#var a : float = droop_height + arch_height
	#var droop_height = a*cosh(base_length/a)
	#var a : float = a*cosh(base_length/a) + arch_height # solve for 'a'?
	#
	#prints(droop_height, arc_length, a, arch_height)
	#
	#for i in range(-segments,segments+1):
		#var x : float = i/segments * base_length
		#var y : float = a*cosh(x/a)
		#line.add_point(Vector2(x+base_length,y-droop_height))
