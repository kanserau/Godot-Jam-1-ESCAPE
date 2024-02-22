extends VBoxContainer

func set_error(err: bool):
	var color = '#ff0000' if err else '#ffff00'
	$History.set('theme_override_colors/font_color', color)

func set_text(input: String, response: String):
	$History.text = " > " + input
	$Response.text = response

func initial(response: String):
	$History.text = "\n"
	$Response.text = response
