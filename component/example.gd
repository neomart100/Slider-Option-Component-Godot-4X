extends Node2D
#godot icon
@onready var icon: Sprite2D = $Icon

##Señal conectada desde el optionComponent: Inspector/nodes/"IDX:in(Variant)"
func _on_option_conainer_idx(optionIndex: Variant) -> void:
	match optionIndex:
		0:#color Blue
			icon.modulate = Color("0000ff")
		1:#Color RED
			icon.modulate = Color("f50060")
		2:#color Yellow
			icon.modulate = Color("ffcd00")
		3:#color Green
			icon.modulate = Color("00ff60")
