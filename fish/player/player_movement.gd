extends Node2D

class_name PlayerMovement

const ACCELERATION := 5
const MAX_VELOCITY := 200
const FRICTION := 0.01

var velocity := Vector2.ZERO

var _player: Area2D
var _sprite: Sprite

func _init(player: Area2D, sprite: Sprite):
	_player = player
	_sprite = sprite


func _physics_process(delta):
	var horizontal_movement = (
		Input.get_action_strength("ui_right")
		- Input.get_action_strength("ui_left")
	)
	var vertical_movement = (
		Input.get_action_strength("ui_down")
		- Input.get_action_strength("ui_up")
	)

	var acceleration_direction = Vector2(
		horizontal_movement, vertical_movement
	).normalized() * ACCELERATION

	_sprite.flip_h = true if horizontal_movement > 0 else false if horizontal_movement < 0 else _sprite.flip_h

	velocity = (velocity + acceleration_direction).clamped(MAX_VELOCITY)
	velocity = velocity.linear_interpolate(Vector2.ZERO, FRICTION)
	_player.position += velocity * delta
