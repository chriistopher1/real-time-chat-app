import 'package:flutter/material.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  const DefaultAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primaryFixed
              )
          ),
        ],
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primaryFixed
      ),
    );
  }

  // This is required for PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
