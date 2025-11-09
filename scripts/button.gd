extends TextureButton
@onready var pendulum = get_node("../pendulum")
@onready var transition = get_node("../transition/anim")

var lvt = preload("res://scenes/tutorial.tscn")

func _ready() -> void:
	AudioPlayer.play_music_level()

func _process(_delta: float) -> void:
	var b1_pos = pendulum.ball1.global_position
	global_position = b1_pos + Vector2(-200, -100)


func _on_pressed() -> void:
	transition.play("out")

func _on_transition_animation_finished(anim_name) -> void:
	if anim_name == "out":
		get_tree().change_scene_to_packed(lvt)
