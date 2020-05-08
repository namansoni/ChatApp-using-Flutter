import 'package:Chat_App/Services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<authService>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Profile"),),
        body: Container(
          child: Column(
            children: <Widget>[
              Text(provider.UserId),
              Text(provider.UserMail),
            ],
          ),
        ),
    );
  }
}