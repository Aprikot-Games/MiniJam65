extends Node2D

signal game_complete
signal hide_instructions
signal show_instructions
var n_levels = 3
var level_cnt = 0
var starting_level = 0

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
			  [1,0,0,1,0,1],
			  [1,1,0,0,1,1],
			  [1,0,0,1,0,0],
			  [1,1,0,1,0,1],
			  [0,1,1,1,0,0]]

var level4 = [[1,1,1,1,1,1],
			  [0,1,0,1,0,1],
			  [1,1,1,0,0,1],
			  [0,1,0,1,1,0],
			  [0,1,1,1,0,0],
			  [0,1,0,1,1,0]]

var levels = [level1, level2, level3, level4]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_HUD_game_over():
	$Level.game_over = true
	$GameOver.play()
	$Music.stop()

func _on_HUD_new_game():
	level_cnt = starting_level
	$Level.generate(levels[level_cnt], level_cnt)
	$Level.game_over = false
	$Music.play()
	emit_signal("show_instructions")

func _on_HUD_destroy_game():
	$Level.destroy()

func _on_Level_win_level():
	$HUD.set_level_complete()

func _on_HUD_new_level():
	$Level.destroy()
	if level_cnt < n_levels:
		level_cnt += 1
		$Level.generate(levels[level_cnt], level_cnt)
		emit_signal("hide_instructions")
	else:
		print("Game finished!")
		emit_signal("game_complete")
