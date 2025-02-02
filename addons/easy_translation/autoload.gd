@icon("res://addons/easy_translation/autoload.png")
extends Node


## A completely new TranslationServer.
## Always use TranslationManager instead of Godot's TranslationServer or GET - Godot Easy Translations won't work.
## The addon heavily relies on the new TranslationManager and doesn't touch Godot's TranslationServer at all.


## Emitted when the language changes.
signal language_changed(new_language: StringName)


## Current language.
## You can use any language codes you want, even codes that doesn't exist (not recommended)!
var language: StringName = TranslationHelper.get_setting("language/default_lang", &"en") : set = set_language, get = get_language


func _ready() -> void:
	# Initial translation request.
	await get_tree().current_scene.ready
	language_changed.emit(language)
	
	await  get_tree().create_timer(1.0).timeout
	set_language(&"pt")


## Sets the current language.
func set_language(new_language: StringName) -> void:
	# Emit signal.
	if new_language != language:
		language_changed.emit(new_language)
	else:
		return
	
	# Update variable.
	language = new_language
	
	# Debug log.
	var debug_log: bool = TranslationHelper.get_setting("debug_log", true)
	if debug_log:
		print("Changing language to: \"%s\"." % language)


## Returns the current language
func get_language() -> StringName:
	return language
