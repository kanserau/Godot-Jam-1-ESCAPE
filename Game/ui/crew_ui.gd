extends Control

@onready var container: Container = get_node('%GridContainer')
@onready var placeholder: RichTextLabel = get_node('%Placeholder')
var labels: Array[RichTextLabel] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for crew in GameManager.crew_members:
		var status: RichTextLabel = placeholder.duplicate()
		status.visible = true
		status.name = crew.name
		container.add_child(status)
		labels.append(status)
	GameManager.connect_to_signal("crew_members_damaged", self, "update_crew")


func update_crew():
	var n = 0
	for crew in GameManager.crew_members:
		n += 1
		var status: RichTextLabel = container.get_node(crew.name)
		status.text = (
			crew.name
			+ ".\nID:" + crew.id
			+ ".\n" + crew.role
			+ ".\n" + Crew.GameTypes.CrewStatus.find_key(crew.status)
			+ "."
		)
	if labels.size() > n:
		labels = labels.slice(0, n)
