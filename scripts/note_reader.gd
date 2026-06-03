extends CanvasLayer

signal note_collected

var _bg: ColorRect
var _image: TextureRect
var _has_note := false
var _is_showing := false


func _ready() -> void:
	layer = 50
	visible = false

	# Subtle full-screen dim
	_bg = ColorRect.new()
	_bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	_bg.color = Color(0, 0, 0, 0.45)
	_bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_bg)

	# Centered image panel — 65% width, anchored to center
	_image = TextureRect.new()
	_image.anchor_left   = 0.175
	_image.anchor_right  = 0.825
	_image.anchor_top    = 0.1
	_image.anchor_bottom = 0.9
	_image.offset_left   = 0
	_image.offset_right  = 0
	_image.offset_top    = 0
	_image.offset_bottom = 0
	_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	_image.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_image)


func _input(event: InputEvent) -> void:
	if not _has_note:
		return
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_TAB:
			_toggle()


func collect(texture: Texture2D) -> void:
	_image.texture = texture
	_has_note = true
	note_collected.emit()
	_set_visible(true)


func _toggle() -> void:
	_set_visible(not _is_showing)


func _set_visible(value: bool) -> void:
	_is_showing = value
	visible = value

	var player = get_tree().get_first_node_in_group("Player")
	if player and player.has_method("set_reading"):
		player.set_reading(value)
