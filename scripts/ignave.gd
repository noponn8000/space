extends DialogueInteract

func interact() -> void:
	Global.hud.dialogue_panel.push_dialogue(get_name_bbcode() + "\n" + dialogues[0], 10.0, true);
