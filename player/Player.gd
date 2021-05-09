extends KinematicBody2D

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

var velocity : Vector2 = Vector2()

onready var sprite = $Sprite

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
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.2)
	  
	
func bounce_back():
	velocity.y = JUMP_FORCE * 0.7
	
func get_hurt(var enemy_position_x):
	
	on_demage_taken_state(true)
	
	velocity.y = JUMP_FORCE * 0.5
	if position.x < enemy_position_x:
		velocity.x =  -700
	elif position.x > enemy_position_x:
		velocity.x = 700
		
	Input.action_release(_action_move_left)
	Input.action_release(_action_move_right)

func on_demage_taken_state(var is_on):
	if is_on:
		set_modulate(Color(1,1,1,0.4))
		$demage_taken.start()
	else:
		set_modulate(Color(1,1,1,1))
		
	set_collision_layer_bit(0, not is_on)
	set_collision_mask_bit(4, not is_on)


func _on_demage_taken_timeout():
	on_demage_taken_state(false)
	
