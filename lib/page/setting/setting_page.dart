import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/component/appbar/home_appbar.dart';
import 'package:realtime_chat_app/component/button/default_button.dart';
import 'package:realtime_chat_app/component/getwidget/custom_widget.dart';
import 'package:realtime_chat_app/component/setting/profile_header.dart';
import 'package:realtime_chat_app/component/setting/setting_item_card.dart';
import 'package:realtime_chat_app/firebase/firebase_app_service.dart';
import 'package:realtime_chat_app/layout/base-layout.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class SettingPage extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const SettingPage({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<AppProvider>(context).user!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: HomeAppbar(
        title: 'Settings',
      ),
      body: BaseLayout(
        child: Column(
          spacing: 20,
          children: [
            ProfileHeader(),
            // SettingItemCard( icon: Icons.vpn_key_outlined, title: 'Account', description: 'Privacy, security, change number'),
            // SettingItemCard(icon: Icons.chat_outlined, title: 'Chat', description: 'Chat history, theme, wallpaper'),
            // SettingItemCard( icon: Icons.notifications_none, title: 'Notifications', description: 'Messages, group and others'),
            // SettingItemCard( icon: Icons.help_outline, title: 'Help', description: 'Help center, contact us, privacy policy'),
            // SettingItemCard( icon: Icons.cloud_download_outlined, title: 'Storage and data', description: 'Network usage, storage usage'),
            SwitchListTile(
              title: const Text("Dark Mode"),
              secondary: const Icon(Icons.dark_mode),
              value: widget.themeMode == ThemeMode.dark,
              onChanged: (value) {
                widget.onToggleTheme();
              },
            ),

          ],
        ),
      ),
    );
  }
}
