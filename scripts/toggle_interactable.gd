extends Node3D

signal state_changed(symbol: String, value: bool)

@export var symbol := "P"
@export var is_on := false

@onready var anim_player: AnimationPlayer = $AnimationPlayer
var anim_name := "Po_Bo|Level_Down" 


func _ready() -> void:
	add_to_group("interactable")

	if anim_player != null and anim_player.has_animation(anim_name):
		if is_on:
			anim_player.play(anim_name)
			anim_player.seek(anim_player.current_animation_length, true) 
		else:
			anim_player.play(anim_name)
			anim_player.seek(0.0, true) 
			anim_player.stop()


func interact(player) -> void:
	is_on = not is_on
	atualizar_visual()
	state_changed.emit(symbol, is_on)


func atualizar_visual() -> void:
	if anim_player != null:
		if is_on:
			anim_player.play(anim_name)
		else:
			anim_player.play_backwards(anim_name)


func get_logic_symbol() -> String:
	return symbol


func get_logic_value() -> bool:
	return is_on
