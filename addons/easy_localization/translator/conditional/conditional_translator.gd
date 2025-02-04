@tool
@icon("res://addons/easy_localization/translator/conditional/icon.png")
class_name ConditionalTranslator extends Translator


## An advanced Translator node.
##
## Can hold up to two StringDatas and translate its [member targets] according to multiple
## TranslationConditions.


## All conditions this [class ConditionalTranslator] is going to evaluate.
@export var conditions: Array[TranslationCondition] = []

@export_group("Data")

## The [class StringData] used when all the conditions are [code]true[/code].
@export var true_data: StringData

## The [class StringData] used when at least one of the conditions is [code]false[/code].
@export var false_data: StringData


## Forces a translation preview with condition states set to [code]true[/code] or [code]false[/code].
var preview_condition: String


func _get_property_list() -> Array[Dictionary]:
	# Create an empty array to store custom properties.
	var properties: Array[Dictionary] = []
	
	# Get the hint string for the enum.
	var hint_str := ""
	for lang: String in LocalizationHelper.get_setting("language/available_langs", ["en"]):
		hint_str += lang + ","
	
	# Add custom properties to the array.
	properties.append({
		"name": "preview_language",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": hint_str
	})
	
	properties.append({
		"name": "preview_condition",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "None,True,False"
	})
	
	# Return all custom properties.
	return properties


func _get_configuration_warnings() -> PackedStringArray:
	# Create an empty array to store errors.
	var warnings: PackedStringArray = []
	
	# No targets error.
	if targets.size() <= 0:
		warnings.push_back("No target nodes defined. Did you forget to set them?")
	
	# No conditions error.
	if conditions.size() <= 0:
		warnings.push_back("No conditions defined. If this is intentional, consider using a BasicTranslator instead.")
	
	# No data defined.
	if (not true_data) and (not false_data):
		warnings.push_back("No data defined. Did you forget to define them?")
	
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
	var debug_log: bool = LocalizationHelper.get_setting("debug_log", true)
	if debug_log:
		if not "None" in preview_condition:
			print("Previewing translation for language \"%s\" with state \"%s\"." % [preview_language, preview_condition])
		else:
			print("Previewing translation for language: \"%s\"." % preview_language)
	
	# Translate.
	translate(preview_language)
	
	# Revert translation.
	await get_tree().create_timer(1.7).timeout
	
	for i: int in range(nodes.size()):
		nodes[i].set_indexed(properties[i], default_values[i])


## Translate all targets using [member data].
func translate(language: StringName = "") -> void:
	# Automatically update language.
	if language == "" and not Engine.is_editor_hint():
		language = TranslationManager.get_language()
	
	# Decide which data is going to be used.
	var data: StringData = true_data
	for condition: TranslationCondition in conditions:
		# Create a new expression.
		var expression := Expression.new()
		
		# Parse the expression string.
		var string: String = condition.expression
		var error := expression.parse(string)
		
		# Check if parse failed.
		if error != OK:
			push_error("Could not parse expression. Error: %s." % error_string(error))
			return
		
		# Execute.
		var result := expression.execute([], self)
		
		# Check if execution failed.
		if expression.has_execute_failed():
			push_error("Expression execution failed.")
			return
		
		# Update data.
		if Engine.is_editor_hint() and not "None" in preview_condition:
			if "True" in preview_condition:
				data = true_data
			else:
				data = false_data
		else:
			if condition.invert:
				if not result:
					data = false_data
			else:
				if not result:
					data = false_data
	
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
		if data:
			node.set_indexed(property, data.get_translated_string(language, self))
