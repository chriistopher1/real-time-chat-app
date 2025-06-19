
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtime_chat_app/model/conversation_model.dart';
import 'package:realtime_chat_app/model/message_model.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class FirebaseAppService {

  final db = FirebaseFirestore.instance;

  // get all user
  Future<(List<UserModel>?, String)> getAllUser() async {

    try{

      final response = await db.collection('user').get();

      final allUserJson = response.docs.map((doc) {

        final data = doc.data();
        // print(data);
        return UserModel.fromJson(data);

      }).toList();

      return (allUserJson, 'Success on getting all user');

    } catch (e){
      print('$e');
      return (null, 'Server error during get all user');
    }

  }

  // update user
  Future<(bool, String)> updateUser({required int userId, required String field, required String newValue}) async {

    try{

      final querySnapshot = await db.collection('user').where('id', isEqualTo: userId).get();

      if(querySnapshot.docs.isEmpty){
        return (false, 'User not found');
      }

      final docId = querySnapshot.docs.first.id;

      await db.collection('user').doc(docId).update({
        field: newValue
      });

      return (true, 'User updated success');

    } catch (e){
      print('$e');
      return (false, 'Server error during update');
    }

  }

  // create new conversation
  Future<(int?, String)> createNewConversation({required int creatorId, required int receiverId}) async {

    try{

      final int newConversationId = DateTime.now().millisecondsSinceEpoch;

      final now = DateTime.now();

      final ConversationModel newConversation = ConversationModel(id: newConversationId, creatorId: creatorId, receiverId: receiverId, createdAt: now, updatedAt: now);

      await db.collection('conversation').add(newConversation.toJson());

      return (newConversationId, 'Success on creating new conversation');

    } catch (e){
      print('$e');
      return (null, 'Server error during creating new conversation');
    }

  }

  // get user conversation
  Future<(ConversationModel?, bool, String)> getUserConversation({required int senderId, required int receiverId}) async {

    try{

      final query = await db.collection('conversation').where('creatorId', whereIn: [senderId, receiverId]).get();

      for (var doc in query.docs) {
        final data = doc.data();
        if ((data['creatorId'] == senderId && data['receiverId'] == receiverId) ||
            (data['creatorId'] == receiverId && data['receiverId'] == senderId)) {
          // print('found');
          return (ConversationModel.fromJson(data),false, '');
        }
      }

      return (null, false, 'Conversation not found');

    } catch (e){
      print('$e');
      return (null,true, 'Server error during get user conversation');
    }

  }

  // get all conversation
  Future<(List<ConversationModel>?, String)> getAllConversation() async {

    try{

      final response = await db.collection('conversation').get();

      final List<ConversationModel> allConversation = response.docs.map((doc) {

        final data = doc.data();
        // print(data);
        return ConversationModel.fromJson(data);

      }).toList();

      return (allConversation, 'Success on getting all conversation');

    } catch (e){
      print('$e');
      return (null, 'Server error during get all conversation');
    }

  }

  // delete conversation
  Future<(bool, String)> deleteConversation({required int conversationId}) async {

    try{

      final query = await db.collection('conversation').where('id', isEqualTo: conversationId).get();

      if(query.docs.isEmpty){
        return (false, 'Conversation not found');
      }

      final docId = query.docs.first.id;

      await db.collection('conversation').doc(docId).delete();

      return (true, 'Deleted conversation');

    } catch (e){
      print('$e');
      return (false, 'Server error during deleting conversation');
    }

  }

  // get all message
  Future<(List<MessageModel>?, String)> getAllMessage({required int conversationId}) async {

    try{

      final query = await db.collection('message').where('conversationId', isEqualTo: conversationId).orderBy('createdAt', descending: true).limit(10).get();

      final messages = query.docs.map((doc) {

        final data = doc.data();
        return MessageModel.fromJson(data);

      }).toList();

      return (messages, 'Success on getting all messages');

    } catch (e){
      print('$e');
      return (null, 'Server error during get all messages');
    }

  }

  // get message count
  Future<int?> messageCount() async {

    try{

      final query = await db.collection('message').get();

      return query.docs.length;

    } catch (e){
      print('$e');
      return null;
    }

  }

  // create new message
  Future<(bool, String)> createNewMessage({required int conversationId, required int senderId, required String message}) async {

    try{

      final int? newMessageId = await messageCount();

      if(newMessageId == null){

        return(false, 'Error during getting message count');

      }

      final MessageModel newMessage = MessageModel(id: newMessageId, conversationId: conversationId, senderId: senderId, message: message, createdAt: DateTime.now());

      await db.collection('message').add(newMessage.toJson());

      return (true, 'Success on creating new conversation');

    } catch (e){
      print('$e');
      return (false, 'Error during creating new message');
    }

  }

  // message stream
  Stream<List<MessageModel>> messageStream({required int conversationId}) {
    return db
        .collection('message')
        .where('conversationId', isEqualTo: conversationId)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MessageModel.fromJson(doc.data()))
        .toList());
  }


}