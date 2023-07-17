class Person {
  String? user;
  String? name;
  List? days;

  Person({this.user, this.name, this.days});

  factory Person.fromPerson(Map<String, dynamic> map) {
    return Person(
        user: map["user"],
        name: map["name"],
        days: map['listProperty']?.split(','));
  }
  Map<String, dynamic> topmap() {
    return {
      "user": user,
      "name": name,
      "days": days?.map((schedule) => schedule.toMap())?.toList()
    };
  }
}
