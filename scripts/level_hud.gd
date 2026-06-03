class_name LevelHUD
extends CanvasLayer

@export var level_id: String = "tutorial"
@export var target_value: bool = true

var _label: Label
var _vars: Dictionary = {}
var _result: bool = false


func _ready() -> void:
	_label = Label.new()
	_label.anchor_left = 0.0
	_label.anchor_right = 0.0
	_label.anchor_top = 0.0
	_label.anchor_bottom = 0.0
	_label.offset_left = 16
	_label.offset_top = 16
	_label.add_theme_font_size_override("font_size", 20)
	_label.modulate = Color(1.0, 1.0, 0.4)
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_label)

	var logic_level = get_tree().get_first_node_in_group("logic_level")
	if logic_level != null:
		logic_level.expression_updated.connect(_on_expression_updated)

	_update_display()


func _on_expression_updated(vars: Dictionary, result: bool) -> void:
	_vars = vars
	_result = result
	_update_display()


func _update_display() -> void:
	var expr := LogicEvaluator.get_expression_text(level_id)
	var target_str := "V" if target_value else "F"
	var result_str := "V" if _result else "F"

	var vars_line := ""
	for key in _vars.keys():
		vars_line += key + "=" + ("V" if _vars[key] else "F") + "  "

	_label.text = vars_line.strip_edges() + "\n" + expr + " = " + result_str + "  (meta: " + target_str + ")"
