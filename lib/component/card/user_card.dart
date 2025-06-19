import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/constant/theme_constant.dart';
import 'package:getwidget/getwidget.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class UserCard extends StatelessWidget {

  final UserModel user;
  final List<UserModel> allUser;

  const UserCard({
    super.key,
    required this.user,
    required this.allUser
  });

  @override
  Widget build(BuildContext context) {

    final appProvider = Provider.of<AppProvider>(context);

    return Expanded(
        child: SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {

              appProvider.setUser(user);

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (Route<dynamic> route) => false,
                arguments: {
                  'allUser': allUser
                }
              );
            },
            child: Card(
                color: Theme.of(context).cardColor,
                elevation: 7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      CircleAvatar(
                          backgroundColor: ThemeConstant.gray,
                          radius: 60,
                          backgroundImage: AssetImage(user.profileImgUrl)
                      ),
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        user.bio,
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Click to act as ${user.name} in this demo.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        )
    );
  }
}


