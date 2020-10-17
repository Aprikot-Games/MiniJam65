extends Node2D

export (PackedScene) var Row

signal player_tick
signal lose_life
signal win_level

var game_over = false
var n_rows = 0
var rows = []
const ROW_HEIGHT = 80
const SPRITE_WIDTH = 80
var n_blocks = 6
const STARTING_POS = [0, 0]
var player_pos = [] + STARTING_POS

func _ready():
	$Player.hide()
	$Friend.hide()
	pass

func destroy():
	for i in range(n_rows):
		if rows[i] != null:
			rows[i].queue_free()
	$Player.hide()
	$Friend.hide()
	player_pos = [] + STARTING_POS
	rows = []

func generate(layout):
	n_rows = len(layout)
	for i in range(n_rows):
		var new_row = Row.instance()
		add_child(new_row)
		new_row.speed = n_rows - i
		new_row.generate(layout[i])
		new_row.position.y = -(i * ROW_HEIGHT)
		rows.append(new_row)
		connect("player_tick", new_row, "on_player_tick")
		$Friend.raise()
		$Player.raise()
	$Player.show()
	$Friend.show()
	$Friend.position.x = n_rows * SPRITE_WIDTH - (SPRITE_WIDTH * n_blocks)/2
	$Friend.position.y = -n_rows * SPRITE_WIDTH

func _process(delta):
	if game_over == true:
		return
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
	$Player.position.x = (player_pos[1] * SPRITE_WIDTH) - (SPRITE_WIDTH * n_blocks)/2
	$Player.position.y = -(player_pos[0] * SPRITE_WIDTH) - 2
	if emit == true:
		emit_signal("player_tick")
		print(player_pos)
		if player_pos[0] == n_rows:
			emit_signal("win_level")
			return
		var block_node = rows[player_pos[0]].blocks[player_pos[1]]
		print(block_node.type)
		if rows[player_pos[0]].blocks[player_pos[1]].type == 3:
			emit_signal("lose_life")
			print("returning to starting position")
			player_pos = [] + STARTING_POS
			print(player_pos)
		if player_pos == [n_rows, 0]:
			emit_signal("win_level")
