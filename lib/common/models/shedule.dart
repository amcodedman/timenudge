class Shedule {
  String title;
  String from;
  String to;
  int? count;
  int? complete;

  Shedule(
      {required this.title,
      required this.from,
      required this.to,
      this.complete,
      this.count});

  factory Shedule.fromShedule(Map<String, dynamic> map) {
    return Shedule(
        title: map["title"],
        from: map["from"],
        to: map["to"],
        complete: map["complete"],
        count: map["count"]);
  }
  Map<String, dynamic> topmap() {
    return {"title": title, "from": from, "to": to};
  }
}
