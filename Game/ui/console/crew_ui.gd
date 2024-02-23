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
	update_crew()
	GameManager.crew_members_damaged.connect(update_crew)


func update_crew():
	var n = 0
	var active = []
	for crew in GameManager.crew_members:
		var status: RichTextLabel = container.get_node(crew.name)
		active.append(crew.name)
		status.text = (
			crew.name
			+ ". ID:" + crew.id
			+ ". " + crew.role
			+ ". " + GameTypes.CrewStatus.find_key(crew.status)
			+ "."
		)
	for l in labels.filter(func(l): return l.name not in active):
		labels.erase(l)
		l.queue_free()
