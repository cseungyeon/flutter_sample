import 'package:flutter_sample/database/constants.dart';

class User {
  final int? id;
  final String name;
  final int age;

  const User({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      Constants.columnId: id,
      Constants.columnName: name,
      Constants.columnAge: age,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[Constants.columnId],
      name: json[Constants.columnName],
      age: json[Constants.columnAge],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, age: $age)';
  }
}
