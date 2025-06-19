import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/component/getwidget/custom_widget.dart';
import 'package:realtime_chat_app/constant/theme_constant.dart';
import 'package:realtime_chat_app/firebase/firebase_app_service.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class MessageCard extends StatefulWidget {

  final UserModel receiver;
  final int id;
  final Future<void> Function(int id) onDelete;

  const MessageCard({
    super.key,
    required this.receiver,
    required this.id,
    required this.onDelete,
  });

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final UserModel user = Provider.of<AppProvider>(context).user!;

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) => widget.onDelete(widget.id),
            backgroundColor: theme.colorScheme.onError,
            foregroundColor: theme.colorScheme.primaryFixed,
            icon: Icons.delete_forever,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
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

          } else{
            CustomWidget().showToast(context: context, message: message, backgroundColor: theme.colorScheme.onError, trailingIcon: Icons.error);
          }

          setState(() {
            isLoading = false;
          });

        },
        child: isLoading ?
        Center(child: CircularProgressIndicator(
          color: theme.colorScheme.primary,
        ),):Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    GFAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(widget.receiver.profileImgUrl)
                    ),
                    Positioned(
                      right: 3,
                      bottom: 3,
                      child: GFBadge(
                        color: widget.receiver.isActive ? theme.colorScheme.tertiary : theme.colorScheme.onError,
                        shape: GFBadgeShape.circle,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.receiver.name,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        'Click here to chat with ${widget.receiver.name}',
                        style: theme.textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            )
        )
      ),
    );
  }
}
