@tool
@icon("res://addons/easy_translation/condition/icon.png")
class_name TranslationCondition extends Resource


## A resource that can run a small piece of code that returns [code]true[/code] or [code]false[/code].
##
## This resource is made to be used by ConditionalTranslators and its code is always ran from the
## translation node.


## If [code]true[/code], inverts the result of [member expression].
@export var invert: bool = false


## The string version of the expression that is going to be evaluated by an [class ConditionalTranslator].
var expression: String = ""


func _get_property_list() -> Array[Dictionary]:
	# Create an empty array to store custom properties.
	var properties: Array[Dictionary] = []
	
	# Add custom properties to the array.
	properties.append({
		"name": "expression",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_EXPRESSION,
	})
	
	# Return all custom properties.
	return properties
