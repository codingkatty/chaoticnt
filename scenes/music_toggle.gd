extends TextureButton

func _ready() -> void:
	update()

func update() -> void:
	if AudioPlayer.is_sound_enabled():
		self.button_pressed = false
	else:
		self.button_pressed = true

func _on_pressed() -> void:
	AudioPlayer.toggle_sound()
	update()
