extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var screenSize

func _ready():
	screenSize = get_viewport_rect().size
	set_process( true )
	print( $Terrain.cell_size )
	var cellSize = $Terrain.cell_size
	for y in range( 0, cellSize.y ):
		for x in range( 0, cellSize.x ):
			var area2D = Area2D.new()
			area2D.position = Vector2( 8 + x * 16, 8 + y * 16 )
			var collisionShape2D = CollisionShape2D.new()
			collisionShape2D.shape = RectangleShape2D.new()
			collisionShape2D.shape.extents = Vector2( 4, 4 )
			area2D.add_child( collisionShape2D )
			area2D.connect( "area_entered", self, "_on_Area2D_area_entered", [ area2D ] )
			add_child( area2D )
			

	
func on_tween_completed( obj, path ):
	print ( obj.get_name() )
	print ( "tween completed" )	
	if obj.get_name() == "Player":
		#$Tween.interpolate_property($Player, "position.x", -16, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		#$Player.position.x = $Player.position.x - 256
		$Terrain.replace_by( $Terrain2 )
		$Terrain.position = $Terrain2.position
		print( $Terrain.position )
		print( $Terrain2.position )
		$Tween.stop_all()
		
		
	
	

func _process(delta):
	$HUD/FPSLabel.text = "FPS:" + str( Engine.get_frames_per_second() )
	#rint( $Player.position.x )
	
	if not $Tween.is_active():
		if $Player.position.x >= ( screenSize.x - 8 + 16 ):# or $Player.position.x < 0:
			#print( "player exited" )
			#$Player.get_node( "CharacterArea2D" ).monitoring = false
			$Terrain2.position = $Terrain.position + Vector2( 256, 0 )
			$Tween.interpolate_property($Terrain, "position", $Terrain.position, $Terrain.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($Terrain2, "position", $Terrain2.position, $Terrain2.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($Player, "position", $Player.position, $Player.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.connect( "tween_completed", self, "on_tween_completed" )
			$Tween.start()
		elif $Player.position.x <= ( - 8):
			#print( "player exited" )
			#$Player.get_node( "CharacterArea2D" ).monitoring = false
			$Terrain2.position = $Terrain.position - Vector2( 256, 0 )
			$Tween.interpolate_property($Terrain, "position", $Terrain.position, $Terrain.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($Terrain2, "position", $Terrain2.position, $Terrain2.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($Player, "position", $Player.position, $Player.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.connect( "tween_completed", self, "on_tween_completed" )
			$Tween.start()
	
	#if Input.is_mouse_button_pressed( BUTTON_LEFT ):
	#		$Tween.interpolate_property(self, "transform/position", position, position+Vector2(100,100), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#		$Tween.start()

func _collided():
	pass


func _on_Area2D_area_entered( area, src ):
	#print( "Map" )
	#print( area.get_name() )
	#print( src.get_name() )
	#print( str( src.position.x ) + " " + str( src.position.y ) )
	#Vector2 worldPos = Vector2( src.position, src.position.y )
	#var gridPos = $Terrain.world_to_map( src.position )
	#print( str( gridPos.x ) + " " + str( gridPos.y ) )
	#print( $Terrain.tile_set.tile_get_name( $Terrain.get_cell( gridPos.x, gridPos.y ) ) )
	#$Tween.interpolate_property(self, "position", $Terrain.position, $Terrain.position+Vector2(-16*16,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#$Tween.start()
	pass




func _on_VisibilityNotifier2D_screen_exited():
	print( "_on_VisibilityNotifier2D_screen_exited" )


func _on_VisibilityNotifier2D_viewport_exited( viewport ):
	print( "_on_VisibilityNotifier2D_viewport_exited" )
