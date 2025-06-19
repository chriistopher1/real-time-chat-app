
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class SettingItemCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String description;

  const SettingItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              icon,
              color: theme.colorScheme.primaryFixed,
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 7,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                description,
                style: theme.textTheme.labelSmall,
              )
            ],
          )
        ],
      ),
    );
  }

}