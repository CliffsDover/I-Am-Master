extends Node2D

export (int) var SPEED
var velocity = Vector2()
var screenSize

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	screenSize = get_viewport_rect().size
	set_process( true )

func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed( "ui_right" ):
		velocity.x += 1
	if Input.is_action_pressed( "ui_left" ):
		velocity.x -= 1
	if Input.is_action_pressed( "ui_down" ):
		velocity.y += 1
	if Input.is_action_pressed( "ui_up" ):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		#$AnimationPlayer.play( "WalkDown" )
		#$AnimatedSprite.play()
	#else:
	#	$AnimatedSprite.stop()	
	position += velocity * delta
	position.x = clamp( position.x, 0, screenSize.x )
	position.y = clamp( position.y, 0, screenSize.y )
	
	
	if velocity.x != 0:
		$AnimationPlayer.play( "WalkRight" )
		#$AnimatedSprite.flip_v = false
		#$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimationPlayer.play( "WalkDown" )
		#$AnimatedSprite.animation = "up"
		#$AnimatedSprite.flip_v = velocity.y > 0
