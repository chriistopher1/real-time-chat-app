import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/constant/theme_constant.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/page/contact/contact_page.dart';
import 'package:realtime_chat_app/page/landing_page.dart';
import 'package:realtime_chat_app/page/message/message_page.dart';
import 'package:realtime_chat_app/page/setting/setting_page.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class HomePage extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final List<UserModel> allUser;

  const HomePage({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
    required this.allUser
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<AppProvider>(context).user!;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: ThemeConstant.lightPrimary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Badge(child: Icon(Icons.message)),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.perm_contact_calendar_sharp),
            label: 'Contacts',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body:
      <Widget>[
        MessagePage(allUser: widget.allUser,),
        ContactPage(allUser: widget.allUser,),
        SettingPage(
          themeMode: widget.themeMode,
          onToggleTheme: widget.onToggleTheme,
        ),
      ][currentPageIndex],
    );
  }
}