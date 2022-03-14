extends Node2D

export(PackedScene) var spawn_entity

const SPAWN_SCREEN_MARGIN := 32.0

onready var screen_size := get_viewport_rect().size
onready var screen_height := screen_size.y
onready var screen_width := screen_size.x

const GROWTH_SPEED := 0.01
const MAX_SIZE = 1.3
const MIN_SIZE = 0.8

var growth_weight = 1

func _on_spawn_timer_timeout():
	var side = get_random_side()
	var spawn_position = get_random_position(side)
	var direction = Vector2.RIGHT if side == Side.LEFT else Vector2.LEFT
	_spawn(spawn_position, direction)


func _spawn(position: Vector2, direction: Vector2):
	var fish = spawn_entity.instance()
	fish.position = position
	fish.direction = direction
	fish.scale = Vector2.ONE * rand_range(growth_weight * MIN_SIZE, growth_weight * MAX_SIZE)
	add_child(fish)


func get_random_position(side) -> Vector2:
	return Vector2(
		-SPAWN_SCREEN_MARGIN if side == Side.LEFT else screen_width + SPAWN_SCREEN_MARGIN,
		rand_range(0, screen_height)
	)


enum Side { LEFT, RIGHT }


func get_random_side() -> int:
	return Side.LEFT if randf() < 0.5 else Side.RIGHT


func _on_game_score_counter_score_increased(_score:int):
	growth_weight = 1 + _score * GROWTH_SPEED
