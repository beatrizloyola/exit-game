class_name LogicLevel
extends Node

signal expression_updated(vars: Dictionary, result: bool)
signal solved

@export var level_id: String = "tutorial"
@export var target_value: bool = true

var vars: Dictionary = {}
var _already_solved := false


func _ready() -> void:
	add_to_group("logic_level")
	call_deferred("_setup")


func _setup() -> void:
	for switch in get_tree().get_nodes_in_group("interactable"):
		if switch.has_signal("state_changed"):
			switch.state_changed.connect(_on_state_changed)
			vars[switch.get_logic_symbol()] = switch.get_logic_value()
	_check()




func _on_state_changed(symbol: String, value: bool) -> void:
	vars[symbol] = value
	_check()


func _check() -> void:
	var result := LogicEvaluator.evaluate(level_id, vars)
	expression_updated.emit(vars, result)
	if result == target_value and not _already_solved:
		_already_solved = true
		solved.emit()
