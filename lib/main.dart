import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/constant/theme_constant.dart';
import 'package:realtime_chat_app/firebase_options.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/page/home_page.dart';
import 'package:realtime_chat_app/page/landing_page.dart';
import 'package:realtime_chat_app/page/message/conversation_page.dart';
import 'package:realtime_chat_app/page/setting/profile_detail_page.dart';
import 'package:realtime_chat_app/page/setting/profile_detail_update_form_page.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _){

        return MaterialApp(
          title: 'Real Time Chat App',
          theme: ThemeData(
              fontFamily: 'Lexend',
              textTheme: TextTheme(
                titleMedium: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700
                ),
                bodyLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
                bodyMedium: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
                labelMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: ThemeConstant.darkGray
                ),
                labelSmall: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: ThemeConstant.darkGray
                ),
              ),
              brightness: Brightness.light,
              cardColor: ThemeConstant.white,
              colorScheme: ColorScheme.light(
                  outline: ThemeConstant.gray,
                  primary: ThemeConstant.primary,
                  secondary: ThemeConstant.white,
                  primaryFixed: ThemeConstant.white,
                  onError: ThemeConstant.red,
                  primaryContainer: ThemeConstant.lightThemeBgColor,
                  tertiary: Colors.green,
                  secondaryContainer: ThemeConstant.gray
              ),
              scaffoldBackgroundColor: ThemeConstant.lightThemeBgColor,
              appBarTheme: AppBarTheme(
                  backgroundColor: ThemeConstant.darkGray,
                  centerTitle: true
              )
          ),
          darkTheme: ThemeData(
              fontFamily: 'Lexend',
              textTheme: TextTheme(
                titleMedium: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),
                bodyLarge: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),
                bodyMedium: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
                labelMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: ThemeConstant.lightGray
                ),
                labelSmall: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: ThemeConstant.lightGray
                ),
              ),
              brightness: Brightness.dark,
              cardColor: ThemeConstant.darkGray,
              colorScheme: ColorScheme.dark(
                  outline: ThemeConstant.white,
                  primary: ThemeConstant.lightPrimary,
                  secondary: ThemeConstant.black,
                  primaryFixed: ThemeConstant.white,
                  onError: ThemeConstant.darkRed,
                  primaryContainer: ThemeConstant.darkThemeBgColor,
                  tertiary: Colors.green,
                  secondaryContainer: ThemeConstant.darkGray
              ),
              scaffoldBackgroundColor: ThemeConstant.darkThemeBgColor,
              appBarTheme: AppBarTheme(
                  backgroundColor: ThemeConstant.darkGray,
                  centerTitle: true
              )
          ),
          themeMode: _themeMode,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(builder: (_) => LandingPage());
            }

            if (settings.name == '/home') {
              final args = settings.arguments as Map<String, dynamic>;
              final allUser = args['allUser']!;
              return MaterialPageRoute(
                builder: (_) => HomePage(
                  themeMode: _themeMode,
                  onToggleTheme: _toggleTheme,
                  allUser: allUser,
                ),
              );
            }

            if (settings.name == '/profile-detail') {
              return MaterialPageRoute(
                builder: (_) => ProfileDetail(),
              );
            }

            if (settings.name == '/profile-detail/update') {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => ProfileDetailUpdateFormPage(
                  title: args['title'],
                  currentValue: args['currentValue'],
                  isNameField: args['isNameField'] ,
                ),
              );
            }

            if(settings.name == '/conversation'){
              final args = settings.arguments as Map<String, dynamic>;
              final UserModel receiver = args['receiver']!;
              final int conversationId = args['conversationId'];

              return MaterialPageRoute(builder: (_) => ConversationPage(
                receiver: receiver,
                conversationId: conversationId,
              ));
            }

            return MaterialPageRoute(builder: (_) => Scaffold(body: Text('Route not found')));
          },
        );

      },
    );
  }
}