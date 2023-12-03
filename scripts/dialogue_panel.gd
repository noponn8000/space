class_name DialoguePanel;
extends Control

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var dialogue_animation: AnimatedSprite2D = $TextureRect/DialogueAnimation
@onready var text: RichTextLabel = $TextureRect/RichTextLabel;

var enabled := false;

func _ready() -> void:
	anim.play("RESET");

func toggle() -> void:
	enabled = !enabled;
	if enabled:
		anim.play("pop_up");
	else:
		anim.play("pop_down");

func push_dialogue(data: String) -> void:
	text.text = text.text + "\n" + data;

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("toggle_dialogue"):
			toggle();
