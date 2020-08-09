import 'package:Chat_App/Screens/LoginScreen.dart';
import 'package:Chat_App/Screens/ProfileScreen.dart';
import 'package:Chat_App/Screens/SettingsScreen.dart';
import 'package:Chat_App/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/authService.dart';
//This is where the app starts (main)
void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: authService()),
        ],
        child: MaterialApp(
        home: LoginScreen(),
        routes: {
          'WelcomeScreen':(ctx)=>WelcomeScreen(),
          'ProfileScreen':(ctx)=>ProfileScreen(),
          'SettingsScreen':(ctx)=>SettingScreen()
        },
      ),
    );
  }
}