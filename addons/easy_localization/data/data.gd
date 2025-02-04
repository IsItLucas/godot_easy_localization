@tool
@icon("res://addons/easy_localization/data/icon.png")
class_name StringData extends Resource


## A resource that stores all translations of a certain string.
##
## A StringData can associate a string and its translated versions and associate them
## with different languages.


## The dictionary key represents the language (eg. en-us), and the dictionary value represents the string.
@export var strings: Dictionary[StringName, BasicTranslationString] = {}


## Returns the translated version of a string for the given [param language].
func get_translated_string(language: StringName, from: Node) -> String:
	# Check if language exists.
	if not strings.has(language):
		push_error("Could not find a translated string for language \"%s\"." % language)
		return "ERROR"
	
	# Return translated version of string.
	return strings[language].get_string(from)
