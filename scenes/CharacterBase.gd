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
		$AnimationPlayer.play( "WalkRight" )
	if Input.is_action_pressed( "ui_left" ):
		velocity.x -= 1
		$AnimationPlayer.play( "WalkLeft" )
	if Input.is_action_pressed( "ui_down" ):
		velocity.y += 1
		$AnimationPlayer.play( "WalkDown" )
	if Input.is_action_pressed( "ui_up" ):
		velocity.y -= 1
		$AnimationPlayer.play( "WalkUp" )

	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		#$AnimationPlayer.play( "WalkDown" )
		#$AnimatedSprite.play()
	#else:
	#	$AnimationPlayer.stop()
	position += velocity * delta
	position.x = clamp( position.x, 0, screenSize.x )
	position.y = clamp( position.y, 0, screenSize.y )


	#if velocity.x != 0:
		#$AnimationPlayer.play( "WalkRight" )
		#$AnimatedSprite.flip_v = false
		#$AnimatedSprite.flip_h = velocity.x < 0
	#	$Body.flip_h = velocity.x < 0
	#	$Hair.flip_h = velocity.x < 0
	#	$Coat.flip_h = velocity.x < 0
	#	$Trousers.flip_h = velocity.x < 0
#		$Shoes.flip_h = velocity.x < 0

#		$Body.flip_v = false
#		$Hair.flip_v = false
#		$Coat.flip_v = false
#		$Trousers.flip_v = false
#		$Shoes.flip_v = false

#	elif velocity.y != 0:
#		$AnimationPlayer.play( "WalkDown" )
		#$AnimatedSprite.animation = "up"
		#$AnimatedSprite.flip_v = velocity.y > 0
