
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class ProfileHeader extends StatelessWidget{

  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context){

    final appProvider = Provider.of<AppProvider>(context);
    final UserModel user = Provider.of<AppProvider>(context).user!;
    final theme = Theme.of(context);

    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          '/profile-detail',
          arguments: user
        );
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: theme.colorScheme.outline,
                    width: 1.5
                )
            )
        ),
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 15,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(user.profileImgUrl)
                ),
                Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      user.bio,
                      style: theme.textTheme.labelSmall,
                    )
                  ],
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                appProvider.clearUser();

                Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
              },
              child: Icon(
                Icons.exit_to_app,
                color: theme.colorScheme.primary,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}