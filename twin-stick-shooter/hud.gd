extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$ColorButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	

func show_logo():
	await get_tree().create_timer(3.0).timeout
	$Logo.show()

func hide_logo():
	$Logo.hide()

func _on_start_button_pressed() -> void: #emit start game signal when pressing the start button
	$StartButton.hide()
	start_game.emit()
	$ColorButton.hide()

func _on_message_timer_timeout() -> void:
	$Message.hide()

signal yellow
signal purple
signal fivetimer
signal tentimer
signal fifteentimer

func _on_color_button_item_selected(id: int) -> void:
	match id:
		0: emit_signal("yellow")
		1: emit_signal("purple")

func _on_timer_5_button_pressed() -> void:
	emit_signal("fivetimer")
	$TimerNode/Timer5Button.hide()
	$TimerNode/Timer10Button.hide()
	$TimerNode/Timer15Button.hide()
	$TimerNode/ChooseTimer.hide()
	$StartButton.show()

func _on_timer_10_button_pressed() -> void:
	emit_signal("tentimer")
	$TimerNode/Timer5Button.hide()
	$TimerNode/Timer10Button.hide()
	$TimerNode/Timer15Button.hide()
	$TimerNode/ChooseTimer.hide()
	$StartButton.show()

func _on_timer_15_button_pressed() -> void:
	emit_signal("fifteentimer")
	$TimerNode/Timer5Button.hide()
	$TimerNode/Timer10Button.hide()
	$TimerNode/Timer15Button.hide()
	$TimerNode/ChooseTimer.hide()
	$StartButton.show()
