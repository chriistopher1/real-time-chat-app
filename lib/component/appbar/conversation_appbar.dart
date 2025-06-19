import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class ConversationAppbar extends StatelessWidget implements PreferredSizeWidget {

  final UserModel receiver;

  const ConversationAppbar({
    super.key,
    required this.receiver,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return AppBar(
      title: Row(
        spacing: 15,
        children: [
          Stack(
            children: [
              GFAvatar(
                radius: 25,
                backgroundImage: AssetImage(receiver.profileImgUrl)
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: GFBadge(
                  color: receiver.isActive ? theme.colorScheme.tertiary : theme.colorScheme.onError,
                  shape: GFBadgeShape.circle,
                  size: 15,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  receiver.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primaryFixed
                  ),

                ),
                Text(
                  '${receiver.isActive ? 'Active now' : 'Last online 14:13'}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primaryFixed
                  ),
                  overflow: TextOverflow.ellipsis,

                )
              ],
            ),
          ),
          Row(
            spacing: 15,
            children: [
              Icon(
                Icons.call_outlined
              ),
              Icon(
                Icons.video_call
              )
            ],
          )
        ],
      ),
      iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primaryFixed
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
