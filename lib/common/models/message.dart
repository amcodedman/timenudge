class Messages {
  String user;
  String text;
  String to;

  Messages({required this.user, required this.text, required this.to});

  factory Messages.fromholiday(Map<String, dynamic> map) {
    return Messages(user: map["user"], text: map["text"], to: map["to"]);
  }
  Map<String, dynamic> topmap() {
    return {"user": user, "text": text, "to": to};
  }
}
