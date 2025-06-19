
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/component/appbar/conversation_appbar.dart';
import 'package:realtime_chat_app/component/appbar/default_appbar.dart';
import 'package:realtime_chat_app/component/getwidget/custom_widget.dart';
import 'package:realtime_chat_app/component/message/message_bubble.dart';
import 'package:realtime_chat_app/component/message/user_conversation_bottom_bar.dart';
import 'package:realtime_chat_app/dummy_data/user_dummy_data.dart';
import 'package:realtime_chat_app/firebase/firebase_app_service.dart';
import 'package:realtime_chat_app/layout/base-layout.dart';
import 'package:realtime_chat_app/model/message_model.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class ConversationPage extends StatefulWidget {

  final UserModel receiver;
  final int conversationId;

  const ConversationPage({
    super.key,
    required this.receiver,
    required this.conversationId
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();

}

class _ConversationPageState extends State<ConversationPage> {

  final TextEditingController _messageController = TextEditingController();

  Stream<List<MessageModel>> _messageStream() {
    return FirebaseAppService()
        .messageStream(conversationId: widget.conversationId);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<AppProvider>(context).user!;
    final theme = Theme.of(context);

    Future<void> handleSend () async {
      final text = _messageController.text.trim();

      if(text.isNotEmpty){

        setState(() {
          isLoading = true;
        });

        final (isCreated, message) = await FirebaseAppService().createNewMessage(conversationId: widget.conversationId, senderId: user.id, message: text);

        setState(() {
          isLoading = false;
        });

        // CustomWidget().showToast(context: context, message: message, backgroundColor: Colors.yellow, trailingIcon: Icons.one_k);

      }
      _messageController.clear();
    }

    return Scaffold(
      appBar: ConversationAppbar(receiver: widget.receiver),
      body: BaseLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: _messageStream(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: theme.colorScheme.primary,),);
                  }

                  if(!snapshot.hasData || snapshot.data!.isEmpty){
                    return Center(child: Text('No messages yet'),);
                  }

                  final List<MessageModel> messages = snapshot.data!;
                  messages.sort((a,b) => b.createdAt.compareTo(a.createdAt));

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {

                      final MessageModel message = messages[index];
                      final bool isUser = message.senderId == user.id;

                      return MessageBubble(
                        message: message.message,
                        isUser: isUser,
                      );

                    },
                  );


                },
              )
            )
          ],
        )
      ),
      bottomNavigationBar: UserConversationBottomBar(messageController: _messageController, onSend: handleSend, isLoading: isLoading,),
    );
  }
}