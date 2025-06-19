import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/component/appbar/home_appbar.dart';
import 'package:realtime_chat_app/component/getwidget/custom_widget.dart';
import 'package:realtime_chat_app/component/message/message_card.dart';
import 'package:realtime_chat_app/dummy_data/user_dummy_data.dart';
import 'package:realtime_chat_app/firebase/firebase_app_service.dart';
import 'package:realtime_chat_app/layout/base-layout.dart';
import 'package:realtime_chat_app/model/conversation_model.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class MessagePage extends StatefulWidget {

  final List<UserModel> allUser;

  const MessagePage({
    super.key,
    required this.allUser
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  List<ConversationModel> allConversation = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllConversation();
  }

  Future<void> _loadAllConversation() async {

    final (allConversationData, message) = await FirebaseAppService().getAllConversation();

    if(allConversationData != null) {

      setState(() {
        allConversation = allConversationData;
      });

    }else{

      CustomWidget().showToast(context: context, message: message, backgroundColor: Theme.of(context).colorScheme.onError, trailingIcon: Icons.error);
      
    }

  }

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<AppProvider>(context).user!;
    final List<UserModel> contacts = widget.allUser.where((u) => u.id != user.id).toList();

    final theme = Theme.of(context);

    return Scaffold(
      appBar: HomeAppbar(
        title: 'Messages',
      ),
      body: BaseLayout(
        child: isLoading ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary,),) : Column(
            children: [
              if(allConversation.isNotEmpty) ...[
                ...contacts.map((receiver) => MessageCard(
                  id: allConversation[0].id,
                  receiver: receiver,
                  onDelete: (id) async {

                    setState(() {
                      isLoading = true;
                    });

                    final (isDeleted, message) = await FirebaseAppService().deleteConversation(conversationId: allConversation[0].id);

                    setState(() {
                      isLoading = false;
                    });

                    if(isDeleted){

                      setState(() {
                        allConversation.removeWhere((element) => element.id == id);
                      });

                      CustomWidget().showToast(context: context, message: message, backgroundColor: theme.colorScheme.primary, trailingIcon: Icons.check);

                    }else{

                      CustomWidget().showToast(context: context, message: message, backgroundColor: theme.colorScheme.onError, trailingIcon: Icons.error);

                    }

                    setState(() {
                      isLoading = false;
                    });

                  },
                ))
              ]
            ]
        )
      ),
    );
  }
}
