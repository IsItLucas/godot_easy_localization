@tool
@icon("res://addons/easy_translation/string/formattable/icon.png")
class_name FormattableTranslationString extends BasicTranslationString


## An extended version of BasicTranslationString that supports string formatting.
##
## This variation of BasicTranslationString supports Godot's string formatting like %s and %f.
## It uses values from other node's properties to format the text.


## All values that are going to be used to format the text, in order.
@export var target_replacements: Array[NodeTarget] = []


## Returns the formatted version of string this resource is holding.
func get_string(from: Node) -> String:
	# Get all values that are going to be used.
	var format: Array = []
	for target: NodeTarget in target_replacements:
		format.push_back(target.get_value(from))
	
	# Return the formatted version of the base string.
	return string % format


## Returns the raw string this resource is holding.
func get_string_raw() -> String:
	return string
