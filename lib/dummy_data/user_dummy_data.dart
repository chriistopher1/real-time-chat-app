import 'package:realtime_chat_app/model/message_model.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class UserDummyData {
  final UserModel alex = UserModel(
    id: 1,
    phone: '081234567890',
    email: 'alex@example.com',
    name: 'Alex',
    bio: 'Loves hiking and outdoor adventures.',
    profileImgUrl:
    'asset/photo/asian_male.jpg',
    isActive: true,
    isBlocked: false,
    preference: 'dark_mode',
    createdAt: DateTime.now().subtract(Duration(days: 30)),
    updatedAt: DateTime.now(),
  );

  final UserModel leona = UserModel(
    id: 2,
    phone: '089876543210',
    email: 'leona@example.com',
    name: 'Leona',
    bio: 'Digital artist and coffee lover.',
    profileImgUrl:
    'asset/photo/asian_female.jpg',
    isActive: true,
    isBlocked: false,
    preference: 'light_mode',
    createdAt: DateTime.now().subtract(Duration(days: 60)),
    updatedAt: DateTime.now(),
  );

  final MessageModel alexMessage = MessageModel(
    id: 001,
    conversationId: 001,
    senderId: 1,
    message: 'Hey Leona, how are you?',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
  );

  final MessageModel leonaMessage = MessageModel(
    id: 002,
    conversationId: 001,
    senderId: 2,
    message: 'I’m good, Alex! How about you?',
    createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
  );

}
