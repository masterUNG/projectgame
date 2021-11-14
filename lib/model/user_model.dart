import 'dart:convert';

class UserModel {
  final double age;
  final String name;
  final String urlProfile;
  UserModel({
    required this.age,
    required this.name,
    required this.urlProfile,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'name': name,
      'urlProfile': urlProfile,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      age: map['age'],
      name: map['name'],
      urlProfile: map['urlProfile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
