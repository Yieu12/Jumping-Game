extends CanvasLayer
signal startGame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$message.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	$startButton.hide()
	$message.hide()
	startGame.emit()

func update_score(score):
	$scoreLabel.text = str(score)

func gameOver(score):
	$message.text = "Game Over\nScore " + str(score) 
	$message.show()
	$gameOverTimer.start()
	await $gameOverTimer.timeout
	
	if score > 0:
		$message.text = "High Score\n" + str(score)
	else:
		$message.hide()
	
	update_score(0)
	$startButton.show()
