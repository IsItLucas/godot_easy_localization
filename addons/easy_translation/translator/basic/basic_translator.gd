@tool
@icon("res://addons/easy_translation/translator/basic/icon.png")
class_name BasicTranslator extends Translator


## Simplest form of a Translator node.
##
## Always translates its [param targets] nodes using the same string data.


## A translated version of a string in all available languages.
@export var data: StringData


func _get_configuration_warnings() -> PackedStringArray:
	# Create an empty array to store errors.
	var warnings: PackedStringArray = []
	
	# No targets error.
	if targets.size() <= 0:
		warnings.push_back("No target nodes defined. Did you forget to set them?")
	
	# No data defined.
	if not data:
		warnings.push_back("No data defined. Did you forget to define it?")
	
	# Return the array with errors.
	return warnings


## Called when the "Preview Translation" button is pressed in the inspector.
func _preview_translation() -> void:
	# Create variables to store the default values for all targets.
	var default_values: Array = []
	var nodes: Array[Node] = []
	var properties: Array[NodePath] = []
	
	# Loop through every target.
	for target: NodeTarget in targets:
		# Get target node.
		var node := target.get_target_node(self)
		if not node:
			return
		
		# Get target property.
		var property := target.get_target_property()
		if not node.get_indexed(property):
			push_error("Could not get \"%s\" in \"%s\"." % [property, node.name])
			return
		
		# Store the default value.
		default_values.push_back(node.get_indexed(property))
		nodes.push_back(node)
		properties.push_back(property)
	
	# Debug log.
	var debug_log: bool = TranslationHelper.get_setting("debug_log", true)
	if debug_log:
		print("Previewing translation for language: \"%s\"." % preview_language)
	
	# Translate.
	translate(preview_language)
	
	# Revert translation.
	await get_tree().create_timer(1.7).timeout
	
	for i: int in range(nodes.size()):
		nodes[i].set_indexed(properties[i], default_values[i])


## Translate all targets using [member data].
func translate(language: StringName = TranslationManager.get_language()) -> void:
	# Loop through every target.
	for target: NodeTarget in targets:
		# Get target node.
		var node := target.get_target_node(self)
		if not node:
			return
		
		# Get target property.
		var property := target.get_target_property()
		if not node.get_indexed(property):
			push_error("Could not get \"%s\" in \"%s\"." % [property, node.name])
			return
		
		# Update node property.
		node.set_indexed(property, data.get_translated_string(language, self))
