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

func _physics_process (delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		sprite.flip_h = not sprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	$Sprite.play("move")

	velocity.y += speed 
	velocity.x  = speed * direction 
	
	velocity = move_and_slide(velocity, Vector2.UP)
