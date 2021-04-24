extends KinematicBody2D

# stats
var score : int = 0
 
# physics
var speed : int = 100
var jumpForce : int = 1200
const gravity : int = 35
 
var velocity : Vector2 = Vector2()

onready var sprite = $Sprite

func _ready():
	pass
	
func _physics_process (delta):

	# movement inputs
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	 
	# jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce
		
	if velocity.y > 0 and not is_on_floor(): 
		$Sprite.play("jump")
		
	if is_on_floor():
		if abs(velocity.x) > 0:
			if Input.is_action_pressed("jump"):
				$Sprite.play("jump")
			else: 
				$Sprite.play("walk")
		elif Input.is_action_pressed("jump"):
			$Sprite.play("jump")
		else:
			$Sprite.play("stand")
		
	# sprite direction
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
		
	# gravity
	velocity.y = velocity.y + gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.2)
	  
	
	
