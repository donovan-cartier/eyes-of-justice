extends CanvasLayer

var dialogue_res
var dialogue_line = {}

@onready var dialogue_bg = $BG
@onready var speaker = $BG/Margin/VBox/Speaker
@onready var dialogue_text = $BG/Margin/VBox/DialogueLabel
@onready var responses = $BG/Margin/VBox/Responses
@onready var response_template = %ResponseTemplate
