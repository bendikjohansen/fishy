extends Area2D

const GROWTH_SPEED = 0.01

signal enemy_eaten
signal player_died

onready var _sprite := $Sprite
onready var bite_audio := AudioStreamPlayer2D.new()
onready var death_audio := AudioStreamPlayer2D.new()


func _ready():
	bite_audio.stream = load("res://fish/player/bite.mp3")
	death_audio.stream = load("res://fish/player/death.mp3")
	add_child(bite_audio)
	get_tree().root.call_deferred("add_child", death_audio)
	add_child(PlayerMovement.new(self, _sprite))


func _on_player_area_entered(enemy: Area2D):
	if enemy is Enemy:
		if enemy.scale <= scale:
			enemy.on_eaten_by_player()
			emit_signal("enemy_eaten")
		else:
			emit_signal("player_died")
			death_audio.play()
			queue_free()


func _on_game_score_counter_score_increased(_score: int):
	bite_audio.play()
	scale = Vector2.ONE * (1 + _score * GROWTH_SPEED)
