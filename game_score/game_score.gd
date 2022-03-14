extends Node

var _score = 0

signal score_increased(score)


func _on_score_increase():
	_score += 1
	emit_signal("score_increased", _score)
