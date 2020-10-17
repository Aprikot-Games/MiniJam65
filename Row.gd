extends Node2D

export (PackedScene) var Block

var grass_tex = preload("res://sprites/pasto.png")
var stone_tex = preload("res://sprites/piedras.png")
var ground_tex = preload("res://sprites/piso.png")

var grass_s_tex = preload("res://sprites/pasto-s.png")
var stone_s_tex = preload("res://sprites/piedras-s.png")
var ground_s_tex = preload("res://sprites/piso-s.png")

var safe_texs = [[grass_tex, stone_tex, ground_tex, void_tex], 
				[grass_s_tex, stone_s_tex, ground_s_tex, void_tex]]

var void_tex = preload("res://sprites/vacio.png")

var dino_tex = preload("res://sprites/dino.png")

var n_blocks = 6
var speed = 1
var tick_cnt = 0
const SPRITE_WIDTH = 80
var row_width = n_blocks * SPRITE_WIDTH
var rng = RandomNumberGenerator.new()

var row = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func generate():
	rng.randomize()
	for i in range(n_blocks):
		var new_block = Block.instance()
		add_child(new_block)
		var tex_indx = rng.randf_range(0, 4)
		new_block.type = tex_indx
		new_block.set_texture(safe_texs[0][tex_indx])
		new_block.position.x = i * SPRITE_WIDTH - (row_width/2)
		row.append(new_block)
	$Label.margin_left = n_blocks * SPRITE_WIDTH - (row_width/2)
	$Label.text = str(tick_cnt) + "/" + str(speed)

func rotate_left():
	var end_block = row[0]
	for i in range(1, n_blocks):
		row[i-1] = row[i]
		row[i-1].position.x -= SPRITE_WIDTH
	row[n_blocks-1] = end_block
	row[n_blocks-1].position.x += (n_blocks-1) * SPRITE_WIDTH

func on_player_tick():
	print("Player Move!")
	tick_cnt += 1
	if tick_cnt > speed:
		rotate_left()
		tick_cnt = 1
	$Label.text = str(tick_cnt) + "/" + str(speed)
