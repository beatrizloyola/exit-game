extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var sensitivity = 0.002

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
var inventario = {
	"coletavel": 0
}

func adicionar_item(nome_do_item: String):
	if inventario.has(nome_do_item):
		inventario[nome_do_item] += 1
		print("Inventário atualizado")
	else:
		print("Item não existe no inventário")
