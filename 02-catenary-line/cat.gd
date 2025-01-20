@tool
extends Node2D

@onready var a=$a
@onready var b=$b
@onready var line=$Line2D
@export var catlength:float=100.0
@export var segments:int=100

@onready var catline = $catline
@onready var catline_base = $catline_base
var cat_a : float :
	get : return abs($cat_a_pivot.position.y)
#@export var cat_a : float = 1.0
@export var cat_xsegs : int = 100
@export var cat_xlen : float = 0.1

var _last_catline_length : float = 0.0

func _physics_process(_delta: float) -> void:
	line.clear_points()
	for i in range(0,segments+1):
		var p : float = i * 1.0 / segments
		line.add_point(lerp(a.position,b.position,p))

		#cosh()
	catline.clear_points()
	catline_base.clear_points()
	var catline_curved_calculated_xlen = cat_a * asinh(cat_xlen / cat_a)
	for i in range(-cat_xsegs,cat_xsegs+1):
		var x : float = i * cat_xlen / cat_xsegs
		catline_base.add_point(Vector2(x,0))
		#print(catline_curved_calculated_xlen)
		x *= catline_curved_calculated_xlen / cat_xlen
		var y : float = cat_a * cosh( x / cat_a )
		catline.add_point(Vector2(x,y))
	
	
	var catline_length : float =  cat_a * sinh(cat_xlen / cat_a)
	if catline_length != _last_catline_length:
		prints("catline floorlength: ", cat_xlen)
		prints("catline length: ",catline_length)
		prints("catline length of reduced curve: ",cat_a * sinh(catline_curved_calculated_xlen / cat_a))
		_last_catline_length = catline_length
		
