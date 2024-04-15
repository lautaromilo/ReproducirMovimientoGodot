extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1020.0
const JUMP_2 = JUMP_VELOCITY * 0.5
var ensalto = false
var saltos = 0

# Aumenta el valor de gravity para una caída más rápida
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2  # Multiplica por 2 para duplicar la gravedad

func _physics_process(delta):
	# Añade la gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Maneja el salto
	if Input.is_action_pressed("ui_up") and is_on_floor() and saltos <1:
		if Input.is_action_just_pressed("ui_up"):
			ensalto = true
			velocity.y = JUMP_2
		else:
			velocity.y = JUMP_VELOCITY
			saltos += 1
			
			
	if !Input.is_action_pressed("ui_up") and is_on_floor() and ensalto:
		ensalto = false
		saltos -= 1
		
		
	var directionX = Input.get_axis("ui_left", "ui_right")
	if directionX:
		velocity.x = directionX * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/30)

	move_and_slide()

#Se hizo lo que se pudo
#No logre hacer que salte más alto al mantener precionado
