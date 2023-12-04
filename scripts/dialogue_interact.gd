class_name DialogueInteract;
extends Interactable;

@export var character_name: String;
@export var character_color: Color;
@export var dialogue_file: String;

var dialogues: Array[String] = [];

func _ready() -> void:
	super._ready();
	load_dialogue();

func load_dialogue() -> void:
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	var content = file.get_as_text();
	var current_dialogue := "";
	
	for line in content.split("\n"):
		if line == "[dialogue]":
			if not current_dialogue.is_empty():
				dialogues.append(current_dialogue);
				current_dialogue = "";
		else:
			current_dialogue += ("\n" + line);
	
	if not current_dialogue.is_empty():
		dialogues.append(current_dialogue);
			
func interact() -> void:
	Global.hud.dialogue_panel.push_dialogue(get_name_bbcode() + "\n" + dialogues[0], 5.0, true);

func get_name_bbcode() -> String:
	return "[color=" + character_color.to_html() + "]" + character_name + "[/color]";
