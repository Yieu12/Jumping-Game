extends Node2D

@export var enemy_scene: PackedScene
var score
var mobTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var enemy = enemy_scene.instantiate()
	
	var a = randi()
	print(a,"\n")
	if a%2 == 0:
		enemy.position = $groundSpawn.position
	else:
		enemy.position = $airSpawn.position

	# Choose the velocity for the mob and direction.
	var velocity = Vector2(500, 0.0)
	enemy.linear_velocity = velocity*-1

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
	
func game_over():
	$scoreTimer.stop()
	$mobTimer.stop()
	$HUD.gameOver(score)
	$mainMusic.stop()
	$gameOver.play()

func new_Game():
	score = 0
	mobTime = 2
	
	get_tree().call_group("enemy", "queue_free")
	$Player.start($startPos.position)
	$scoreTimer.start()
	$mobTimer.start()
	$mainMusic.play()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
	#Every 5 score the mobs spawn rate will be increased 
	if score%5 == 0 && mobTime > 0.5:
		mobTime -=0.1
		$mobTimer.start(mobTime)
		print(mobTime)
