extends Node2D

export (PackedScene) var Block

var grass_tex = preload("res://sprites/pasto.png")
var stone_tex = preload("res://sprites/piedras.png")
var ground_tex = preload("res://sprites/piso.png")

var grass_s_tex = preload("res://sprites/pasto-s.png")
var stone_s_tex = preload("res://sprites/piedras-s.png")
var ground_s_tex = preload("res://sprites/piso-s.png")

var safe_texs = [[grass_tex, stone_tex, ground_tex], 
				[grass_s_tex, stone_s_tex, ground_s_tex]]

var void_tex = preload("res://sprites/vacio.png")

var dino_tex = preload("res://sprites/dino.png")

var n_blocks = 6
var speed = 1
const SPRITE_WIDTH = 80
var row_width = n_blocks * SPRITE_WIDTH
var rng = RandomNumberGenerator.new()

var row = []
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in range(n_blocks):
		var new_block = Block.instance()
		add_child(new_block)
		var tex_indx = rng.randf_range(0, 3)
		new_block.type = tex_indx
		new_block.set_texture(safe_texs[0][tex_indx])
		new_block.position.x = i * SPRITE_WIDTH - (row_width/2)
		row.append(new_block)

func _on_tick():
	pass
