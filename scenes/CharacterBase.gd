extends Node2D

enum BodyType { Male_1 = 0, Female_1, Male_2, Female_2, Male_3, Female_3, Male_4, Female_4, Male_5, Female_5, BodyType_Num }

enum CoatType { None = -1, Coat_1, Coat_2, Coat_3, Coat_4, Coat_5, Coat_6, Coat_7, Coat_8, Coat_9, Coat_10, CoatType_Num }

enum TrousersType { None = -1, Trousers_1, Trousers_2, Trousers_3, Trousers_4, Trousers_5, Trousers_6, Trousers_7, Trousers_8, Trousers_9, Trousers_10, TrousersType_Num }

enum RobeType { None = -1, Robe_1, Robe_2, Robe_3, Robe_4, Robe_5, Robe_6, Robe_7, Robe_8, Robe_9, Robe_10, RobeType_Num }

enum MantleType { None = -1, Mantle_1, Mantle_2, Mantle_3, Mantle_4, Mantle_5, Mantle_6, Mantle_7, Mantle_8, Mantle_9, Mantle_10, MantleType_Num }

enum SkirtType { None = -1, Skirt_1, Skirt_2, Skirt_3, Skirt_4, Skirt_5, Skirt_6, Skirt_7, Skirt_8, Skirt_9, Skirt_10, SkirtType_Num }

enum ShoesType { None = -1, Shoes_1, Shoes_2, Shoes_3, Shoes_4, Shoes_5, Shoes_6, Shoes_7, Shoes_8, Shoes_9, Shoes_10, ShoesType_Num }

enum HairType { None = -1,
Hair_1, 
Hair_2,
Hair_3,
Hair_4,
Hair_5,
Hair_6,
Hair_7,
Hair_8,
Hair_9,
Hair_10,
Hair_11, 
Hair_12,
Hair_13,
Hair_14,
Hair_15,
Hair_16,
Hair_17,
Hair_18,
Hair_19,
Hair_20,
Hair_21, 
Hair_22,
Hair_23,
Hair_24,
Hair_25,
Hair_26,
Hair_27,
Hair_28,
Hair_29,
Hair_30,
Hair_31, 
Hair_32,
Hair_33,
Hair_34,
Hair_35,
Hair_36,
Hair_37,
Hair_38,
Hair_39,
Hair_40,
HairType_Num
}

export (int) var SPEED
export (BodyType) var BODY
export (HairType) var HAIR
export (CoatType) var COAT
export (RobeType) var ROBE
export (TrousersType) var TROUSERS
export (SkirtType) var SKIRT
export (MantleType) var MANTLE
export (ShoesType) var SHOES

var velocity = Vector2()
var screenSize

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	randomize()
	screenSize = get_viewport_rect().size
	set_process( true )
	set_physics_process( true )
	HAIR = randi() % HairType_Num
	COAT = randi() % CoatType_Num
	TROUSERS = randi() % TrousersType_Num
	SHOES = randi() % ShoesType_Num

	
	var animations = [ "WalkDown", "WalkUp", "WalkLeft", "WalkRight" ]
	var offsets = [ 0, 2, 1, 3 ]
	var tracks = [ "Coat:frame", "Trousers:frame", "Shoes:frame" ]
	var keys = [ COAT, TROUSERS, SHOES ]
	
	var animation
	var track
	
	var animationIndex = 0
	for a in animations:
		animation = $AnimationPlayer.get_animation( a )
		track = animation.find_track( "Hair:frame")
		animation.track_set_key_value( track, 0, HAIR * 4 + offsets[ animationIndex ] )
		var trackIndex = 0
		for t in tracks:
			track = animation.find_track( t )
			animation.track_set_key_value( track, 0, keys[trackIndex] * 12 + 4 + offsets[ animationIndex ] )
			animation.track_set_key_value( track, 1, keys[trackIndex] * 12 + 0 + offsets[ animationIndex ] )
			animation.track_set_key_value( track, 2, keys[trackIndex] * 12 + 4 + offsets[ animationIndex ] )
			animation.track_set_key_value( track, 3, keys[trackIndex] * 12 + 8 + offsets[ animationIndex ] )	
			trackIndex += 1
		
		animationIndex += 1
	

#func (delta):
func _physics_process(delta):
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


	if $MoveAnimationPlayer.is_playing():
		return
		

		#$AnimationPlayer.play( "WalkDown" )
		#$AnimatedSprite.play()
	#else:
	#	$AnimationPlayer.stop()
	#print( velocity )
	if $KinematicBody2D.test_move( transform, velocity * SPEED ):
		print( "collided" )
	else:
		#position += velocity #* delta
		#position.x = clamp( position.x, 0, screenSize.x )
		#position.y = clamp( position.y, 0, screenSize.y )
		if velocity.length() > 0:
			velocity = velocity * SPEED
			var a = $MoveAnimationPlayer.get_animation( "Move" )
			var t = a.find_track( ".:position" )
			a.track_set_key_value( t, 0, position )
			a.track_set_key_value( t, 1, position + velocity )
			$MoveAnimationPlayer.play( "Move" )  
		
		
	#var collision = $KinematicBody2D.move_and_collide( velocity )
	#if collision != null:
	#	print ( collision.collider_id )
	#else:
	#	position += velocity #* delta
	#	position.x = clamp( position.x, 0, screenSize.x )
	#	position.y = clamp( position.y, 0, screenSize.y )

		


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


func _on_Area2D_area_entered( area ):
	pass
	#print( "Character" )
	#print( area.get_name() )
