extends Node2D

@export var l1 = 200
@export var l2 = 200
@export var m1 = 20
@export var m2 = 20
@export var a1 = 0.0
@export var a2 = 0.0

var a1_v = 0.0
var a2_v = 0.0
var a1_a = 0.0
var a2_a = 0.0
var g = 1200.0

@onready var ball1 = $ball1
@onready var ball2 = $ball2
@onready var line1 = $line1
@onready var line2 = $line2

var x1 = 0.0
var y1 = 0.0
var x2 = 0.0
var y2 = 0.0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	a1_a = (-g * (2 * m1 + m2) * sin(a1) - m2 * g * sin(a1 - 2 * a2) - 2 * sin(a1 - a2) * m2 * (a2_v * a2_v * l2 + a1_v * a1_v * l1 * cos(a1 - a2))) / (l1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2)))

	a2_a = (2 * sin(a1 - a2) * (a1_v * a1_v * l1 * (m1 + m2) + g * (m1 + m2) * cos(a1) + a2_v * a2_v * l2 * m2 * cos(a1 - a2))) / (l2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2)))

	x1 = l1 * sin(a1)
	y1 = l1 * cos(a1)
	ball1.position = Vector2(x1, y1)

	x2 = x1 + l2 * sin(a2)
	y2 = y1 + l2 * cos(a2)
	ball2.position = Vector2(x2, y2)

	line1.points = [Vector2(0, 0), Vector2(x1, y1)]
	line2.points = [Vector2(x1, y1), Vector2(x2, y2)]

	a1_v += a1_a * delta
	a2_v += a2_a * delta
	a1 += a1_v * delta
	a2 += a2_v * delta
