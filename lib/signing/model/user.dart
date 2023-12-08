// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String userName;
  String email;
  String password;
  String userId;
  static User? _instance;
  static const userReferenceKey = 'Users';
  User({
    required this.userName,
    required this.email,
    required this.password,
    required this.userId,
  });

  factory User.getInstance({
    String userName = '',
    String email = '',
    String password = '',
    String userId = '',
  }) {
    return _instance ??= User(
      userName: userName,
      email: email,
      password: password,
      userId: userId,
    );
  }
  User copyWith({
    String? userName,
    String? email,
    String? password,
    String? userId,
  }) {
    return User(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'password': password,
      'userId': userId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['userName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userName: $userName, email: $email, password: $password, userId: $userId)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.email == email &&
        other.password == password &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        userId.hashCode;
  }
}
