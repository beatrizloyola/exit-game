extends StaticBody3D
@export var nome_do_item: String = "coletavel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			coletar_item()

func coletar_item():
	print("%s clicado % [nome_do_item]")
	var player = get_tree().get_first_node_in_group("Player")
	
	if player and player.has_method("adicionar_item"):
		player.adicionar_item(nome_do_item)
		
		var cena = get_tree().current_scene
		
		if cena.has_method("mostrar_mensagem"):
			cena.mostrar_mensagem("Coletasse %s" % [nome_do_item])
		
		queue_free()
