import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final int id;
  final String phone;
  final String email;
  final String name;
  final String bio;
  final String profileImgUrl;
  final bool isActive;
  final bool isBlocked;
  final String preference;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.phone,
    required this.email,
    required this.name,
    required this.bio,
    required this.profileImgUrl,
    required this.isActive,
    required this.isBlocked,
    required this.preference,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      phone: json['phone'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
      profileImgUrl: json['profileImgUrl'] as String,
      isActive: json['isActive'] as bool,
      isBlocked: json['isBlocked'] as bool,
      preference: json['preference'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }


  Map<String, dynamic> toJson() => {
    'id': id,
    'phone': phone,
    'email': email,
    'name': name,
    'bio': bio,
    'profile_img_url': profileImgUrl,
    'is_active': isActive,
    'is_blocked': isBlocked,
    'preferences': preference,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  UserModel copyWith({
    String? name,
    String? bio,
  }) {
    return UserModel(
      id: id,
      phone: phone,
      email: email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profileImgUrl: profileImgUrl,
      isActive: isActive,
      isBlocked: isBlocked,
      preference: preference,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
