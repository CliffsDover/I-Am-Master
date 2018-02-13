extends Node2D

enum BodyType { Male_1 = 0, Female_1, Male_2, Female_2, Male_3, Female_3, Male_4, Female_4, Male_5, Female_5, BodyType_Num }

enum CoatType { None = -1, Coat_1, Coat_2, Coat_3, Coat_4, Coat_5, Coat_6, Coat_7, Coat_8, Coat_9, Coat_10, CoatType_Num }

enum TrousersType { None = -1, Trousers_1, Trousers_2, Trousers_3, Trousers_4, Trousers_5, Trousers_6, Trousers_7, Trousers_8, Trousers_9, Trousers_10 }

enum RobeType { None = -1, Robe_1, Robe_2, Robe_3, Robe_4, Robe_5, Robe_6, Robe_7, Robe_8, Robe_9, Robe_10 }

enum MantleType { None = -1, Mantle_1, Mantle_2, Mantle_3, Mantle_4, Mantle_5, Mantle_6, Mantle_7, Mantle_8, Mantle_9, Mantle_10 }

enum SkirtType { None = -1, Skirt_1, Skirt_2, Skirt_3, Skirt_4, Skirt_5, Skirt_6, Skirt_7, Skirt_8, Skirt_9, Skirt_10 }

enum ShoesType { None = -1, Shoes_1, Shoes_2, Shoes_3, Shoes_4, Shoes_5, Shoes_6, Shoes_7, Shoes_8, Shoes_9, Shoes_10 }

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
	HAIR = randi() % HairType_Num
	COAT = randi() % CoatType_Num
	#COAT = 2
	print( COAT )
	var animations = $AnimationPlayer.get_animation_list()
	for animation in animations:
		print( animation )
	
	var animation = $AnimationPlayer.get_animation( "WalkDown" )
	var track = animation.find_track( "Hair:frame")
	animation.track_set_key_value( track, 0, HAIR * 4 + 0 )
	
	track = animation.find_track( "Coat:frame")
	animation.track_set_key_value( track, 0, COAT * 12 + 4 )
	animation.track_set_key_value( track, 1, COAT * 12 + 0 )
	animation.track_set_key_value( track, 2, COAT * 12 + 4 )
	animation.track_set_key_value( track, 3, COAT * 12 + 8 )	
	
	animation = $AnimationPlayer.get_animation( "WalkUp" )
	track = animation.find_track( "Hair:frame")
	animation.track_set_key_value( track, 0, HAIR * 4 + 2 )
	
	track = animation.find_track( "Coat:frame")
	animation.track_set_key_value( track, 0, COAT * 12 + 4 + 2 )
	animation.track_set_key_value( track, 1, COAT * 12 + 0 + 2 )
	animation.track_set_key_value( track, 2, COAT * 12 + 4 + 2 )
	animation.track_set_key_value( track, 3, COAT * 12 + 8 + 2 )	
	
	
	animation = $AnimationPlayer.get_animation( "WalkLeft" )
	track = animation.find_track( "Hair:frame")
	animation.track_set_key_value( track, 0, HAIR * 4 + 1 )

	track = animation.find_track( "Coat:frame")
	animation.track_set_key_value( track, 0, COAT * 12 + 4 + 1 )
	animation.track_set_key_value( track, 1, COAT * 12 + 0 + 1 )
	animation.track_set_key_value( track, 2, COAT * 12 + 4 + 1 )
	animation.track_set_key_value( track, 3, COAT * 12 + 8 + 1 )	
	
	animation = $AnimationPlayer.get_animation( "WalkRight" )
	track = animation.find_track( "Hair:frame")
	animation.track_set_key_value( track, 0, HAIR * 4 + 3 )
	
	track = animation.find_track( "Coat:frame")
	animation.track_set_key_value( track, 0, COAT * 12 + 4 + 3 )
	animation.track_set_key_value( track, 1, COAT * 12 + 0 + 3 )
	animation.track_set_key_value( track, 2, COAT * 12 + 4 + 3 )
	animation.track_set_key_value( track, 3, COAT * 12 + 8 + 3 )	
	

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