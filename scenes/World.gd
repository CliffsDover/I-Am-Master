extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screenSize
var currentRegion = Vector2( 0, 0 )

func _ready():
	screenSize = get_viewport_rect().size
	set_process( true )
	
	var region = LoadRegion( currentRegion.x + 0 , currentRegion.y + 0 )
	#region.position = Vector2( ( currentRegion.x + 0 ) * 256, ( currentRegion.y + 0 ) * 256 )
	$Regions.add_child( region )
	
	region = LoadRegion( currentRegion.x - 1 , currentRegion.y + 0 )
	#region.position = Vector2( ( currentRegion.x - 1 ) * 256, ( currentRegion.y + 0 ) * 256 )
	$Regions.add_child( region )
	
	region = LoadRegion( currentRegion.x + 1 , currentRegion.y + 0 )
	#region.position = Vector2( ( currentRegion.x + 1 ) * 256, ( currentRegion.y + 0 ) * 256 )
	$Regions.add_child( region )
	
	region = LoadRegion( currentRegion.x + 0 , currentRegion.y + 1 )
	$Regions.add_child( region )
	
	region = LoadRegion( currentRegion.x + 0 , currentRegion.y - 1 )
	$Regions.add_child( region )
	
	ListAllRegions()
	
	pass

func _process(delta):
	$HUD/FPSLabel.text = "FPS:" + str( Engine.get_frames_per_second() )
	$HUD/PositionLabel.text = "Position: ( " + str( int( $Player.position.x ) ) + ", " + str( int( $Player.position.y ) ) + " )"
	$HUD/RegionLabel.text = "Region: ( " + str( int( currentRegion.x ) ) + ", " + str( int( currentRegion.y ) ) + " )"
	#print( get_viewport_rect().position.x )
	
	if not $TweenEffect.is_active():
		if $Player.position.x >= ( $Camera.position.x + screenSize.x - 8 + 16 ):# or $Player.position.x < 0:
			#print( "player exited" )
			#$Player.get_node( "CharacterArea2D" ).monitoring = false
			#$Terrain2.position = $Terrain.position + Vector2( 256, 0 )
			#$TweenEffect.interpolate_property($Region_Current, "position", $Region_Current.position, $Region_Current.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Region_East, "position", $Region_East.position, $Region_East.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Player, "position", $Player.position, $Player.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$TweenEffect.interpolate_property( $Camera, "position", $Camera.position, $Camera.position + Vector2( 256, 0 ), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT ) 
			$TweenEffect.connect( "tween_completed", self, "on_tween_completed" )
			$TweenEffect.start()
		elif $Player.position.x <= ( $Camera.position.x - 8):
			#print( "player exited" )
			#$Player.get_node( "CharacterArea2D" ).monitoring = false
			#$Terrain2.position = $Terrain.position - Vector2( 256, 0 )
			#$TweenEffect.interpolate_property($Region_Current, "position", $Region_Current.position, $Region_Current.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Region_West, "position", $Region_West.position, $Region_West.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Player, "position", $Player.position, $Player.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$TweenEffect.interpolate_property( $Camera, "position", $Camera.position, $Camera.position - Vector2( 256, 0 ), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT ) 
			$TweenEffect.connect( "tween_completed", self, "on_tween_completed" )
			$TweenEffect.start()
		elif $Player.position.y >= ( $Camera.position.y + screenSize.y - 8 + 16 ):# or $Player.position.x < 0:
			#print( "player exited" )
			#$Player.get_node( "CharacterArea2D" ).monitoring = false
			#$Terrain2.position = $Terrain.position + Vector2( 256, 0 )
			#$TweenEffect.interpolate_property($Region_Current, "position", $Region_Current.position, $Region_Current.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Region_East, "position", $Region_East.position, $Region_East.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Player, "position", $Player.position, $Player.position-Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$TweenEffect.interpolate_property( $Camera, "position", $Camera.position, $Camera.position + Vector2( 0, 256 ), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT ) 
			$TweenEffect.connect( "tween_completed", self, "on_tween_completed" )
			$TweenEffect.start()
		elif $Player.position.y <= ( $Camera.position.y - 8):
			#print( "player exited" )
			#$Player.get_node( "CharacterArea2D" ).monitoring = false
			#$Terrain2.position = $Terrain.position - Vector2( 256, 0 )
			#$TweenEffect.interpolate_property($Region_Current, "position", $Region_Current.position, $Region_Current.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Region_West, "position", $Region_West.position, $Region_West.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			#$TweenEffect.interpolate_property($Player, "position", $Player.position, $Player.position+Vector2(256,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$TweenEffect.interpolate_property( $Camera, "position", $Camera.position, $Camera.position - Vector2( 0, 256 ), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT ) 
			$TweenEffect.connect( "tween_completed", self, "on_tween_completed" )
			$TweenEffect.start()	

func LoadRegion( x, y ):
	#print( "res://scenes/Region_" + str( x ) + "_" + str( y ) + ".tscn" )
	var fileName = "res://scenes/Region_" + str( x ) + "_" + str( y ) + ".tscn"
	if Directory.new().file_exists( fileName ):
		var region = load( fileName ).instance()
		region.name = "Region_" + str( x ) + "_" + str( y )
		region.position = Vector2( 256 * x, 256 * y )
		return region
	else:
		return null
	
func LoadRegionByName( regionName ):
	var fileName = "res://scenes/" + regionName + ".tscn"
	#print( "res://scenes/Region_" + str( x ) + "_" + str( y ) + ".tscn" )
	if Directory.new().file_exists( fileName ):
		var region = load( fileName ).instance()
		region.name = regionName
		var regionPostfix = regionName.split( "Region_" )[1]
		var regionPosition = regionPostfix.split( "_" )
		var x = int( regionPosition[0] )
		var y = int( regionPosition[1] )
		print( "[LoadRegionByName] res://scenes/Region_" + str( x ) + "_" + str( y ) + ".tscn" )
		region.position = Vector2( 256 * x, 256 * y )
		return region
	else:
		return null

func on_tween_completed( obj, path ):
	#print ( obj.get_name() )
	print ( "tween completed" )	
	#if obj.get_name() == "Player":
		#$Tween.interpolate_property($Player, "position.x", -16, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		#$Player.position.x = $Player.position.x - 256
		#$Terrain.replace_by( $Terrain2 )
		#$Terrain.position = $Terrain2.position
	print( $Player.position.x )
	print( $Player.position.y )
	
	var negX = 0
	if $Player.position.x < 0:
		negX = 1

	var negY = 0
	if $Player.position.y < 0:
		negY = 1
		
	currentRegion = Vector2( int( ( $Player.position.x ) / 256 - negX ), int( ( $Player.position.y ) / 256 - negY ) )
	
	print( "Current region:" + str( currentRegion.x ) + "," + str( currentRegion.y ) ) 
	#var region = LoadRegion( currentRegion.x + 1 , currentRegion.y + 0 )
	#region.position = Vector2( ( currentRegion.x + 1 ) * 256, ( currentRegion.y + 0 ) * 256 )
	#$Regions.add_child( region )
	
	var nearbyRegions = [ Vector2( currentRegion.x, currentRegion.y ), Vector2( currentRegion.x - 1, currentRegion.y ), Vector2( currentRegion.x + 1, currentRegion.y ), Vector2( currentRegion.x , currentRegion.y - 1 ), Vector2( currentRegion.x, currentRegion.y + 1 ) ]
	var nearbyRegionsNames = []
	for nearbyRegion in nearbyRegions:
		var nearbyRegionName = "Region_" + str( nearbyRegion.x ) + "_" + str( nearbyRegion.y )
		nearbyRegionsNames.append( nearbyRegionName )
		print( "N:" + nearbyRegionName )
		
	print( "Removing unrelated regions" )
	print( $Regions.get_child_count() )	
	var allRegions = $Regions.get_children()
	for r in allRegions:
		if not nearbyRegionsNames.has( r.get_name() ):
			print( "R:" + r.get_name() )
			$Regions.remove_child( r )
	
	ListAllRegions()
	
	for r in nearbyRegionsNames:
		print( "N_O:" + r )
		
	print( "Adding nearby regions" )
	for r in $Regions.get_children():
		print( r.get_name() )
		if nearbyRegionsNames.has( r.get_name() ):
			var index = nearbyRegionsNames.find( r.get_name() ) 
			nearbyRegionsNames.remove( index )
		
	for r in nearbyRegionsNames:
		print( "N_N:" + r )
		var region = LoadRegionByName( r )
		#region.position = Vector2( ( currentRegion.x + 0 ) * 256, ( currentRegion.y + 0 ) * 256 )
		$Regions.add_child( region )
	
	ListAllRegions()
	$TweenEffect.stop_all()
	#var s = load( "res://scenes/Region_2_0.tscn" ).instance()
	#s.position = Vector2( 256 * 2, 256 * 0 )
	#add_child( s )
	#move_child( s, $Region_East.get_index() )
	#$Region_Current.replace_by( $Region_East )
	#$Region_East.replace_by( s )
	
	
func ListAllRegions():
	print( "[ListAllRegions]" )
	for i in range( 0, $Regions.get_child_count() ):
		print( $Regions.get_child( i ).get_name() )