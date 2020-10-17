extends CanvasLayer

signal game_over
signal destroy_game
signal new_game
signal new_level
var empty_live_tex = preload("res://sprites/empty-heart.png")
var full_live_tex = preload("res://sprites/heart.png")

var inst = false
const MAX_LIVES = 3
var live_cnt = MAX_LIVES
var lives 
var game_state = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	lives = [$Heart1, $Heart2, $Heart3]
	set_game_menu()

func fill_lives():
	live_cnt = MAX_LIVES
	for live in lives:
		live.set_texture(full_live_tex)

func hide_lives():
	for live in lives:
		live.hide()

func show_lives():
	for live in lives:
		live.show()

func set_game_start():
	fill_lives()
	show_lives()
	$Message.hide()
	$Button.hide()
	$Cover.hide()
	$CoverFinal.hide()

func set_game_menu():
	$Button.show()
	$Message.hide()
	$Cover.show()
	$CoverFinal.hide()
	hide_lives()
	$Instructions.hide()

func set_game_over():
	$Message.text = "Game Over"
	$Message.show()
	$Timer.start()
	$Instructions.hide()

func set_final():
	$Message.hide()
	hide_lives()
	$CoverFinal.show()
	$Timer.wait_time = 6
	$Timer.start()
	game_state = 2
	$Instructions.hide()

func set_level_complete():
	$Message.text = "Complete!"
	$Message.show()
	game_state = 1
	$Timer.start()
	$Instructions.hide()

func _on_Level_lose_life():
	live_cnt -= 1
	if live_cnt < 0:
		emit_signal("game_over")
		set_game_over()
	else:
		lives[live_cnt].set_texture(empty_live_tex)

func _on_Button_pressed():
	emit_signal("new_game")
	set_game_start()

func _on_Timer_timeout():
	if game_state == 0:
		set_game_menu()
		emit_signal("destroy_game")
	elif game_state == 1:
		set_game_start()
		game_state = 0
		emit_signal("new_level")
	else:
		game_state = 0
		set_game_menu()

func _on_Game_game_complete():
	print("HUD game complete")
	set_final()

func _on_Game_hide_instructions():
	$Instructions.hide()

func _on_Game_show_instructions():
	$Instructions.show()
