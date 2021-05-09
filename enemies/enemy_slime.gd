extends KinematicBody2D

var velocity  = Vector2()

const _animation_move = "move"
const _animation_hit = "hit"

export var direction = -1
export var detects_cliffs = true 

export var speed : int = 100

onready var sprite = $Sprite

func _ready():
	if direction == 1:
		sprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	
	sprite.play(_animation_move)

func _physics_process (delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		sprite.flip_h = not sprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	

	velocity.y += speed 
	velocity.x  = speed * direction 
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_checker_body_entered(body):
	sprite.play(_animation_hit)
	set_modulate(Color(1,1,1,0.5))
	
	pause_mode = true
	
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_layer_bit(4, false)
	$sides_checker.set_collision_mask_bit(0, false)
	$Timer.start()
	
	#call func of player object to get "reaction" 
	body.bounce_back()
	

func _on_sides_checker_body_entered(body):
	body.get_hurt(position.x)

func _on_Timer_timeout():
	#remove itself from the scene 
	queue_free()
