class UserDm {
  final int userId;
  final String userName;
  final String fullName;
  final bool appAccess;

  UserDm({
    required this.userId,
    required this.userName,
    required this.fullName,
    required this.appAccess,
  });

  factory UserDm.fromJson(Map<String, dynamic> json) {
    return UserDm(
      userId: json['UserId'],
      userName: json['Username'],
      fullName: json['FULLNAME'],
      appAccess: json['AppAccess'],
    );
  }
}
