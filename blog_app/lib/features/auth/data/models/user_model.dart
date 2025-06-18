import 'package:blog_app/features/auth/domain/entities/user_profile.dart';

class UserModel extends UserProfile {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.toJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
