class_name DialoguePanel;
extends Control

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var dialogue_animation: AnimatedSprite2D = $TextureRect/DialogueAnimation
@onready var text: RichTextLabel = $TextureRect/RichTextLabel;
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var enabled := false;

signal toggled (bool);
signal dialogue_finished;

func _ready() -> void:
	text.visible_characters = 0;
	anim.play("RESET");

func toggle() -> void:
	enabled = !enabled;
	if enabled:
		anim.play("pop_up");
	else:
		anim.play("pop_down");
		
	toggled.emit(enabled);

func push_dialogue(data: String, animation_duration: float, force_open: bool = true, sound: bool = true) -> void:
	if force_open and !enabled:
		toggle();
	if sound:
		audio.play();

	text.text = text.text + "\n" + data;
	var tween = get_tree().create_tween();
	
	tween.tween_property(text, "visible_characters", text.visible_characters + len(data), animation_duration);
	
	await tween.finished;
	if sound:
		audio.stop();
	dialogue_finished.emit();
	
func push_dialogue_array(data: Array, animation_duration: float, force_open: bool = true, sound: bool = true) -> void:
	for dialogue in data:
		push_dialogue(dialogue, animation_duration, force_open, sound);
		await dialogue_finished;

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("toggle_dialogue"):
			toggle();
