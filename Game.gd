extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var n_levels = 3
var level_cnt = 0

var level1 = [[1,1,1,1,1,1],
			  [0,1,1,1,1,1],
			  [1,1,1,0,1,1],
			  [1,1,0,1,1,1],
			  [0,1,1,1,1,1],
			  [1,1,1,1,1,0]]

var level2 = [[1,1,1,1,1,1],
			  [1,1,0,1,0,1],
			  [1,1,1,0,1,1],
			  [1,1,0,1,0,0],
			  [1,1,0,1,0,1],
			  [1,1,0,1,1,0]]

var level3 = [[1,1,1,1,1,1],
			  [1,1,0,1,0,1],
			  [1,1,1,0,1,1],
			  [1,1,0,1,0,0],
			  [1,1,0,1,0,1],
			  [1,1,0,1,1,0]]

var levels = [level1, level2, level3]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_HUD_game_over():
	$Level.game_over = true

func _on_HUD_new_game():
	$Level.generate(level1)
	$Level.game_over = false

func _on_HUD_destroy_game():
	$Level.destroy()

func _on_Level_win_level():
	$HUD.set_level_complete()

func _on_HUD_new_level():
	$Level.destroy()
	if level_cnt < n_levels:
		level_cnt += 1
	$Level.generate(levels[level_cnt])
