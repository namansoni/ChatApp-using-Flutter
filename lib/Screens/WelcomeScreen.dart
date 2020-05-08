import 'package:Chat_App/Screens/popupmenuitems.dart';
import 'package:flutter/material.dart';

import 'CameraScreen.dart';
import 'MessageScreen.dart';
import 'StatusScreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat App"),
          backgroundColor: Color.fromRGBO(32, 32, 32, 0.8),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: onSelected,
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext ctx) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.camera),
              ),
              Tab(icon: Icon(Icons.message)),
              Tab(icon: Icon(Icons.image))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[CameraScreen(), MessageScreen(), StatusScreen()],
        ),
      ),
    );
  }

  void onSelected(String value) {
    if(value==Constants.profile){
        Navigator.of(context).pushNamed('ProfileScreen');
    }else if(value==Constants.settings){
        Navigator.of(context).pushNamed('SettingsScreen');
    }
  }
}
