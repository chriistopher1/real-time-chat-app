import 'package:flutter/material.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class ProfileDetailCard extends StatelessWidget {

  final IconData icon;
  final String fieldTitle;
  final String data;
  final void Function() onTap;

  const ProfileDetailCard({
    super.key,
    required this.icon,
    required this.fieldTitle,
    required this.data,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          spacing: 15,
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: theme.colorScheme.primary,
                child: Icon(
                  icon,
                  color: theme.colorScheme.primaryFixed,
                  size: 30,
                )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fieldTitle,
                    style: theme.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data,
                    style: theme.textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
