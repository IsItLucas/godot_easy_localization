@tool
@icon("res://addons/easy_translation/translator/icon.png")
class_name Translator extends Node


## Base class for all Translators.
##
## Only has a target nodes property and a preview translation feature, so this class can't translate nodes by itself.
## Translation functions are definied in each Translator type.


## Nodes and properties to be translated.
@export var targets: Array[NodeTarget]

@export_group("Preview")

## The language that is going to be used in the preview.
var preview_language: String

@export_tool_button("Preview Translation") var preview_action = _preview_translation


func _ready() -> void:
	# Stabilish connections.
	if not Engine.is_editor_hint():
		TranslationManager.language_changed.connect(_on_language_changed)
	
	# Initial translation.
	translate(TranslationManager.get_language())


func _get_property_list() -> Array[Dictionary]:
	# Create an empty array to store custom properties.
	var properties: Array[Dictionary] = []
	
	# Get the hint string for the enum.
	var hint_str := ""
	for lang: String in TranslationHelper.get_setting("language/available_langs", ["en"]):
		hint_str += lang + ","
	
	# Add custom properties to the array.
	properties.append({
		"name": "preview_language",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": hint_str
	})
	
	# Return all custom properties.
	return properties


func _get_configuration_warnings() -> PackedStringArray:
	# Create an empty array to store errors.
	var warnings: PackedStringArray = []
	
	# No targets error.
	if targets.size() <= 0:
		warnings.push_back("No target nodes defined. Did you forget to set them?")
	
	# Return the array with errors.
	return warnings


## Called when the "Preview Translation" button is pressed in the inspector.
func _preview_translation() -> void:
	pass


## Called when the language changes.
func _on_language_changed(new_language: StringName) -> void:
	# Update translation.
	translate(new_language)


## Translate all targets using [member data].
func translate(_language: StringName = TranslationManager.get_language()) -> void:
	pass
