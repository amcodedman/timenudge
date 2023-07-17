class Holidays {
  String title;
  String day;

  Holidays({
    required this.title,
    required this.day,
  });

  factory Holidays.fromholiday(Map<String, dynamic> map) {
    return Holidays(
      title: map["title"],
      day: map["from"],
    );
  }
  Map<String, dynamic> topmap() {
    return {"title": title, "day": day};
  }
}
