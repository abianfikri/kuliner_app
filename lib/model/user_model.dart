import 'dart:convert';

class UserModel {
  String uid;
  String username;
  String email;
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(uid: $uid, username: $username, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ username.hashCode ^ email.hashCode;
}
