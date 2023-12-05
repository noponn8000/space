class_name DialogueInteract;
extends Interactable;

@export var character_name: String;
@export var character_color: Color;
@export var dialogue_file: String;

var dialogues: Array[String] = [];
var dialogue_index := 0;

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
	if Global.hud.dialogue_panel.playing:
		Global.hud.dialogue_panel.skip_dialogue();
		return;

	if dialogue_index == 0:
		Global.hud.dialogue_panel.push_dialogue(get_name_bbcode() + "\n" + dialogues[dialogue_index], 5.0, true);
	elif dialogue_index < len(dialogues):
		Global.hud.dialogue_panel.push_dialogue(dialogues[dialogue_index], 5.0, true);
	else:
		Global.hud.dialogue_panel.skip_dialogue();

	dialogue_index += 1;

func get_name_bbcode() -> String:
	return "[color=" + character_color.to_html() + "]" + character_name + "[/color]";
