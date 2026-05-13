extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dica()

func mostrar_mensagem(texto: String):
	%Label.text = texto
	%Label.visible = true
	await get_tree().create_timer(2.0).timeout
	%Label.visible = false

func mostrar_dica():
	%Tip.visible = true

func esconder_dica():
	%Tip.visible = false

func dica():
	var player = get_tree().get_first_node_in_group("Player")
	
	if player.inventario["coletavel"] > 0:
		if Input.is_action_just_pressed("dica"):
			mostrar_dica()
		if Input.is_action_just_released("dica"):
			esconder_dica()
