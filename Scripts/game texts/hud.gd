extends CanvasLayer


var messages = [
	"Welcome to the Hollow World!. press Enter to Continue",
	"Use the arrow keys to move left and right.",
	"press Spacebar to jump",
	"press X to swing your sword.",
	"Enjoy!"
	]
	
var current_message = 0
var typing = false

func _ready():
	display_message(messages[current_message])
	
func display_message(text):
	typing = true
	$Panel/intro_text.text = ""
	for letter in text:
		if !typing:
			break
		$Panel/intro_text.text += letter
		await get_tree(). create_timer(0.05).timeout
	typing = false
	
func _input(event):
	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		typing = false
		current_message += 1
		if current_message < messages.size():
			display_message(messages[current_message])
		else:
			$Panel.hide()
