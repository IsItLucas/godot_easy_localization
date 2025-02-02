@tool
@icon("res://addons/easy_translation/string/basic/icon.png")
class_name BasicTranslationString extends Resource


## A resource that holds a basic string.
##
## This resource holds a basic string data that can be used by Translator and TranslationData
## nodes to translate scenes.


## The string this resource holds.
@export_multiline var string: String


## Sets the string this resource holdes to [param new_string].
func set_string(new_string: String) -> void:
	string = new_string


## Returns the string this resource is holding.
func get_string(from: Node) -> String:
	return string
