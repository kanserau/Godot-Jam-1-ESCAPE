class_name DynamicLoader

static func load_from(path: String) -> Array[Resource]:
	var dir = DirAccess.open(path)
	if dir == null:
		return []
	dir.list_dir_begin()
	var file = dir.get_next()
	var data: Array[Resource] = []
	while file != "":
		if file.ends_with('.tres') or file.ends_with('.tres.remap'):
			data.append(load(path + '/' + file))
		file = dir.get_next()
	return data
