extends VBoxContainer

func set_text(input: String, response: String):
	$History.text = " > " + input
	$Response.text = response

func initial(response: String):
	$History.text = "\n"
	$Response.text = response
