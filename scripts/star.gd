extends Area2D

@onready var transition = get_node("../Player/transition/anim")

var next_lvl
var next_level_number = 1

func _ready() -> void:
	transition.play("in")

	var crnt_scene_file = get_tree().current_scene.scene_file_path

	if crnt_scene_file.begins_with("res://scenes/level"):
		next_level_number = crnt_scene_file.to_int() + 1

	var next_lvl_path = "res://scenes/level" + str(next_level_number) + ".tscn"

	if ResourceLoader.exists(next_lvl_path):
		next_lvl = load(next_lvl_path)
	else:
		next_lvl = load("res://scenes/win.tscn")

func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		transition.play("out")

func _on_transition_animation_finished(anim_name:StringName) -> void:
	if anim_name == "out":
		await get_tree().create_timer(0.1).timeout
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_packed(next_lvl)
