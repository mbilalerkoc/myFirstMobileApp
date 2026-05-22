import 'dart:convert';

class UserModel {
  String? uid;
  final String email;
  final String name;
  final String surname;
  final String username;
  final String? profilePhoto;

  UserModel({
    this.uid,
    required this.email,
    required this.name,
    required this.surname,
    required this.username,
    this.profilePhoto,
  });

  UserModel copyWith({  // UserModel'i kopyalayarak yeni bir UserModel olusturur
    String? uid,
    String? email,
    String? name,
    String? surname,
    String? username,
    String? profilePhoto,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() { // UserModel'i Map'e cevirir
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'surname': surname,
      'username': username,
      'profilePhoto': profilePhoto,
    };
  }
  factory UserModel.fromMap(Map<String, dynamic> map) { // Map'i UserModel'e cevirir
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      surname: map['surname'],
      username: map['username'],
      profilePhoto: map['profilePhoto'],
    );
  }

  String toJson() => toMap().toString(); // UserModel'i JSON string'e cevirir

  factory UserModel.fromJson(String source) => UserModel.fromMap(Map<String, dynamic>.from(jsonDecode(source))); // JSON string'i UserModel'e cevirir

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, surname: $surname, username: $username, profilePhoto: $profilePhoto)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.surname == surname &&
        other.username == username &&
        other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        username.hashCode ^
        profilePhoto.hashCode;
  }
}