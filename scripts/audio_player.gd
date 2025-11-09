extends AudioStreamPlayer

const lvl_music = preload("res://assets/chaos_dance.mp3")
var sound_enabled = false

func _play_music(music: AudioStream, volume = 0.2):	
	if stream == music:
		return

	stream = music
	volume_db = volume
	
	if sound_enabled:
		play()

func play_music_level():
	_play_music(lvl_music)

func stop_music():
	stream = null
	stop()

func toggle_sound():
	sound_enabled = not sound_enabled
	if not sound_enabled:
		stop()
	elif stream:
		play()

func is_sound_enabled() -> bool:
	return sound_enabled