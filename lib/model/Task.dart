class Task {
  String name;
  String description;

  Task({required this.name, required this.description});

  factory Task.getList(Map m) {
    return Task(name: m["name"], description: m["description"]);
  }
  Map tomap() {
    return {"name": name, "description": description};
  }
}
