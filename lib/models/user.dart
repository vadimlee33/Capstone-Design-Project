class User {
  String id;
  String username;
  String email;
  Map<String, dynamic> diaryEntries;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.diaryEntries});
}
