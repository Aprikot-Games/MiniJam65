extends Node2D

export (PackedScene) var Row

signal player_tick

var n_rows = 0
var rows = []
const ROW_HEIGHT = 80
const SPRITE_WIDTH = 80
var n_blocks = 6

var player_pos = [0, 0]

func _ready():
	pass

func generate(layout):
	n_rows = layout[0] 
	for i in range(n_rows):
		var new_row = Row.instance()
		add_child(new_row)
		new_row.generate()
		new_row.speed = n_rows - i + 1
		new_row.position.y = -(i * ROW_HEIGHT)
		rows.append(new_row)
		connect("player_tick", new_row, "on_player_tick")
		$Player.raise()

func _process(delta):
	var emit = true
	if Input.is_action_just_pressed("ui_up") and \
	player_pos[0] < n_rows:
			player_pos[0] += 1
	elif Input.is_action_just_pressed("ui_down") and \
	player_pos[0] > 0:
			player_pos[0] -= 1
	elif Input.is_action_just_pressed("ui_left") and \
	player_pos[1] > 0:
			player_pos[1] -= 1
	elif Input.is_action_just_pressed("ui_right") and \
	player_pos[1] < n_blocks - 1:
			player_pos[1] += 1
	else:
		emit = false
	if emit == true:
		emit_signal("player_tick")
		$Player.position.x = (player_pos[1] * SPRITE_WIDTH) - (SPRITE_WIDTH * n_blocks)/2
		$Player.position.y = -(player_pos[0] * SPRITE_WIDTH) - 2
		print(player_pos)
