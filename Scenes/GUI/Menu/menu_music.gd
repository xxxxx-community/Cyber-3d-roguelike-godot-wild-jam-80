extends AudioStreamPlayer


const menu_music = preload("res://Assets/Sound/Music/Menu_01.wav")

func _play_music(music: AudioStream, volume = -25.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_menu():
	_play_music(menu_music)
