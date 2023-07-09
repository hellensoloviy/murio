extends CharacterBody2D

signal demage_taken(amount)

# stats
var score : int = 0
 
# physics
const SPEED : int = 100
const JUMP_FORCE : int = -1200
const GRAVITY : int = 35
 
const _action_jump = "jump"
const _action_move_left = "move_left"
const _action_move_right = "move_right"

const _animation_jump = "jump"
const _animation_walk = "walk"
const _animation_stand = "stand"

const _EVENT_DEMAGE_TAKEN = "demage_taken"

var velocity : Vector2 = Vector2()

@onready var sprite = $Sprite2D

func _ready():
	pass
	
func _physics_process (delta):

	# movement inputs
	if Input.is_action_pressed(_action_move_left):
		velocity.x -= SPEED
	if Input.is_action_pressed(_action_move_right):
		velocity.x += SPEED
	 
	# jump input
	if Input.is_action_just_pressed(_action_jump) and is_on_floor():
		velocity.y = JUMP_FORCE
		
	if velocity.y > 0 and not is_on_floor(): 
		sprite.play(_animation_jump)
		
	if is_on_floor():
		if abs(velocity.x) > 0:
			if Input.is_action_pressed(_action_jump):
				sprite.play(_animation_jump)
			else: 
				sprite.play(_animation_walk)
		else:
			sprite.play(_animation_stand)
		
	# sprite direction
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
		
	# gravity
	velocity.y = velocity.y + GRAVITY
	
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity
	
	velocity.x = lerp(velocity.x,0,0.2)
	  
	
func bounce_back():
	velocity.y = JUMP_FORCE * 0.7
	
func get_hurt(enemy_position_x):
	
	on_demage_taken_state(true)
	emit_signal(_EVENT_DEMAGE_TAKEN, 1)
	
	velocity.y = JUMP_FORCE * 0.5
	if position.x < enemy_position_x:
		velocity.x =  -700
	elif position.x > enemy_position_x:
		velocity.x = 700
		
	Input.action_release(_action_move_left)
	Input.action_release(_action_move_right)

func on_demage_taken_state(is_on):
	if is_on:
		set_modulate(Color(1,1,1,0.4))
		$demage_taken.start()
	else:
		set_modulate(Color(1,1,1,1))
		
	set_collision_layer_value(0, not is_on)
	set_collision_mask_value(4, not is_on)


func _on_demage_taken_timeout():
	on_demage_taken_state(false)
	

func _on_health_system_health_depleted():
	#TODO: - 
	#end game here - death event 
	pass 
