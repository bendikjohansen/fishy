extends Area2D

class_name Enemy

export(Vector2) var direction

onready var _sprite = $Sprite
var _enemy_movement: EnemyMovement


func _ready():
	_sprite.flip_h = direction == Vector2.RIGHT
	_enemy_movement = EnemyMovement.new(self, direction)
	add_child(_enemy_movement)


func on_eaten_by_player():
	queue_free()
