
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserConversationBottomBar extends StatelessWidget {

  final TextEditingController messageController;
  final VoidCallback onSend;
  final bool isLoading;

  const UserConversationBottomBar({
    super.key,
    required this.messageController,
    required this.onSend,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primaryContainer,
      padding: EdgeInsets.symmetric(vertical: 35, horizontal: 12),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              style: TextStyle(
                color: theme.colorScheme.primaryFixed
              ),
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: theme.colorScheme.primaryFixed
                ),
                filled: true,
                fillColor: theme.colorScheme.secondaryContainer,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: IconButton(
                  icon : Icon(
                    Icons.emoji_emotions,
                    size: 30,
                  ),
                  color: theme.colorScheme.primaryFixed,
                  onPressed: () {

                  },
                ),
                suffixIcon: IconButton(
                    icon : Icon(
                      Icons.attachment,
                      size: 30,
                    ),
                    color: theme.colorScheme.primaryFixed,
                    onPressed: () {

                    },
                  )
              ),
            ),
          ),
          isLoading ? CircularProgressIndicator(color: theme.colorScheme.primary,) : IconButton(
            onPressed: onSend,
            icon: Icon(
              Icons.send_rounded,
              color: theme.colorScheme.primary,
              size: 35,
            ),
          )

        ],
      ),
    );

  }

}