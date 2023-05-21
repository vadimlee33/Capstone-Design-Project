class User {
  final String id;
  final String username;
  final String email;
  final Map<int, Map<String, dynamic>> diaryEntries;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.diaryEntries
  });
}
