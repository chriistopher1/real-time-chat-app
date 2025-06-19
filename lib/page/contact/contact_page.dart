import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/component/appbar/home_appbar.dart';
import 'package:realtime_chat_app/component/contact/user_contact_card.dart';
import 'package:realtime_chat_app/dummy_data/user_dummy_data.dart';
import 'package:realtime_chat_app/layout/base-layout.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class ContactPage extends StatefulWidget {

  final List<UserModel> allUser;

  const ContactPage({
    super.key,
    required this.allUser
  });

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<AppProvider>(context).user!;

    final theme = Theme.of(context);

    final List<UserModel> contacts = widget.allUser.where((u) => u.id != user.id).toList();

    return Scaffold(
      appBar: HomeAppbar(
        title: 'Contacts',
      ),
      body: BaseLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            if (contacts.isNotEmpty) ...[
              Text(
                contacts[0].name[0],
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
            ],
            ...contacts.map((receiver) => UserContactCard(receiver: receiver)),
          ]
        )
      ),
    );
  }
}
