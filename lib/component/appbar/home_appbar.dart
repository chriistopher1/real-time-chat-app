import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HomeAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<AppProvider>(context).user!;

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
          Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primaryFixed
              )
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(user.profileImgUrl)
          )
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }

  // This is required for PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
