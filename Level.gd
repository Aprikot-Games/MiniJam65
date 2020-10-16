extends Node2D

export (PackedScene) var Row

var n_rows = 0
const ROW_HEIGHT = 80
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate(layout):
	n_rows = layout[0] 
	for i in range(n_rows):
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
