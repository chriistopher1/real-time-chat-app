import 'package:flutter/material.dart';
import 'package:realtime_chat_app/component/card/user_card.dart';
import 'package:realtime_chat_app/component/getwidget/custom_widget.dart';
import 'package:realtime_chat_app/constant/theme_constant.dart';
import 'package:realtime_chat_app/dummy_data/user_dummy_data.dart';
import 'package:realtime_chat_app/firebase/firebase_app_service.dart';
import 'package:realtime_chat_app/layout/base-layout.dart';
import 'package:realtime_chat_app/model/user_model.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  List<UserModel> allUser = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  Future<void> getAllUser() async {

    setState(() {
      isLoading = true;
    });

    final (data, message) = await FirebaseAppService().getAllUser();

    setState(() {
      isLoading = false;
    });

    if(data != null){
      setState(() {
        allUser = data;
      });
    }


  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat App Demo',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primaryFixed
          )
        ),
      ),
      body: isLoading ?
      Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.primary,
        ),
      ) :
      BaseLayout(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: allUser.map((user) => UserCard(user: user, allUser: allUser,)).toList()
        ),
      )
    );
  }
}
