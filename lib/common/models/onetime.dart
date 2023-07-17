class OneTime {
  String title;
  String from;
  String to;

  int? complete;

  OneTime(
      {required this.title,
      required this.from,
      required this.to,
      this.complete,
      s});

  factory OneTime.fromPerson(Map<String, dynamic> map) {
    return OneTime(
        title: map["title"],
        from: map["from"],
        to: map["to"],
        complete: map["complete"]);
  }
  Map<String, dynamic> topmap() {
    return {"title": title, "from": from, "to": to};
  }
}
