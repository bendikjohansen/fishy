extends Node2D

class_name EnemyMovement

const MAX_VELOCITY := 180
const MIN_VELOCITY := 50

var _velocity: Vector2

var _fish: Area2D


func _init(fish: Area2D, direction: Vector2):
	_fish = fish
	_velocity = direction.normalized() * rand_range(MIN_VELOCITY, MAX_VELOCITY)


func _physics_process(delta):
	var sin_x := sin(_fish.position.x * delta)
	var y_variance := Vector2.UP * sin_x * rand_range(0, 0.3)
	_fish.position = _fish.position + _velocity * delta + y_variance
