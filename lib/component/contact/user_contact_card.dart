
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/component/getwidget/custom_widget.dart';
import 'package:realtime_chat_app/constant/theme_constant.dart';
import 'package:realtime_chat_app/firebase/firebase_app_service.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class UserContactCard extends StatefulWidget {

  final UserModel receiver;

  const UserContactCard({
    super.key,
    required this.receiver
  });

  @override
  State<UserContactCard> createState() => _UserContactCardState();
}

class _UserContactCardState extends State<UserContactCard>{

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final UserModel user = Provider.of<AppProvider>(context).user!;

    return InkWell(
      onTap: () async {

        setState(() {
          isLoading = true;
        });

        final (userConvo, isError, message) = await FirebaseAppService().getUserConversation(senderId: widget.receiver.id, receiverId: user.id);

        if(userConvo != null && isError == false){

          Navigator.pushNamed(
              context,
              '/conversation',
              arguments: {
                'receiver': widget.receiver,
                'conversationId': userConvo.id
              }
          );

          setState(() {
            isLoading = false;
          });

        }else if(userConvo == null && isError == false){

          final (newConversationId, message) = await FirebaseAppService().createNewConversation(creatorId: user.id, receiverId: widget.receiver.id);

          if(newConversationId != null){

            setState(() {
              isLoading = false;
            });

            Navigator.pushNamed(
                context,
                '/conversation',
                arguments: {
                  'receiver': widget.receiver,
                  'conversationId': newConversationId
                }
            );

          } else {

            CustomWidget().showToast(context: context, message: message, backgroundColor: theme.colorScheme.onError, trailingIcon: Icons.error);

            setState(() {
              isLoading = false;
            });


          }

        } else{
          CustomWidget().showToast(context: context, message: message, backgroundColor: theme.colorScheme.onError, trailingIcon: Icons.error);
        }

        setState(() {
          isLoading = false;
        });

      },
      child: isLoading ?
          Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          )
          :
      Row(
        spacing: 25,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: ThemeConstant.gray,
            backgroundImage: AssetImage(widget.receiver.profileImgUrl),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                widget.receiver.name,
                style: theme.textTheme.bodyLarge,
              ),
              Text(
                widget.receiver.bio,
                style: theme.textTheme.labelSmall,
              )
            ],
          )
        ],
      )
    );

  }

}