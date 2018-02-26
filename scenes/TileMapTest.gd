extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
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
			$Terrain.add_child( area2D )
	

func _process(delta):
	$HUD/FPSLabel.text = "FPS:" + str( Engine.get_frames_per_second() )

func _collided():
	pass


func _on_Area2D_area_entered( area, src ):
	print( "Map" )
	print( area.get_name() )
	print( src.get_name() )
	print( str( src.position.x ) + " " + str( src.position.y ) )
	#Vector2 worldPos = Vector2( src.position, src.position.y )
	var gridPos = $Terrain.world_to_map( src.position )
	print( str( gridPos.x ) + " " + str( gridPos.y ) )
