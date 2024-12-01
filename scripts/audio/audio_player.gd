extends AudioStreamPlayer

const music_one : AudioStreamMP3 = preload("res://assets/music/power-of-the-wind-lofi-153794.mp3")
const music_two : AudioStreamMP3 = preload("res://assets/music/slow-lo-fi-beats-191762.mp3")
var removed_music : AudioStreamMP3 = null

#const music_queue : Array = []

func _add_music(music: AudioStreamMP3):
	if !self.playing or self.finished:
		stream = music
func _play_music():
	if self.has_stream_playback():
		return
	self.play()

func _change_music():
	if music_two != stream:
		#print("Changed to Music Two")
		_add_music(music_two)
		_play_music()
	elif music_one != stream:
		#print("Changed to Music One")
		_add_music(music_one)
		_play_music()

func play_music_level():
	_add_music(music_one) 
	_play_music()

func _on_finished() -> void:
	#print("Finished!")
	_change_music()
