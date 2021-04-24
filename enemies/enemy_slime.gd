extends KinematicBody2D

var velocity  = Vector2()

export var direction = -1
export var detects_cliffs = true 

export var speed : int = 100

onready var sprite = $Sprite

func _ready():
	if direction == 1:
		sprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	
	sprite.play("move")

func _physics_process (delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		sprite.flip_h = not sprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	

	velocity.y += speed 
	velocity.x  = speed * direction 
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_checker_body_entered(body):
	sprite.play("hit")
	speed = 0
	
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	
	
