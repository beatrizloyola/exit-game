class_name Note
extends Node3D

@export var note_texture: Texture2D


func _ready() -> void:
	add_to_group("interactable")


func interact(_player) -> void:
	NoteReader.collect(note_texture)
	queue_free()
