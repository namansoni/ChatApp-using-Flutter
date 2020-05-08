import 'package:Chat_App/Services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController fadeanimationController;
  Animation animation;
  Animation fadeAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    fadeanimationController=AnimationController(vsync: this,duration: Duration(milliseconds: 700));
    animation = Tween<Size>(begin: Size(0, 0), end: Size(250, 40)).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(fadeanimationController);
    fadeAnimation.addListener(() => setState(() {}));
    animation.addListener(() => setState(() {}));
    animationController.forward();
    fadeanimationController.forward();
  }

  final formKey = GlobalKey<FormState>();
  final ScaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool page = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<authService>(context);
    return Scaffold(
      key: ScaffoldKey,
      backgroundColor: Color.fromRGBO(23, 35, 51, 1),
      body: SingleChildScrollView(
          child: Container(
        height: 640,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Welcome to Chat App!",
                  style: TextStyle(color: Colors.white60, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                page
                    ? FadeTransition(
                        opacity: fadeAnimation,
                        child: Text(
                          "Please Login...",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 20,
                          ),
                        ),
                      )
                    : FadeTransition(
                        opacity: fadeAnimation,
                        child: Text(
                          "Please Register...",
                          style: TextStyle(color: Colors.white54, fontSize: 20),
                        )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 260,
              child: new Theme(
                  data: ThemeData(
                    primaryColor: Colors.white,
                    primarySwatch: Colors.amber,
                    accentColor: Colors.white,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: animation.value.width,
                          height: 100,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Username",
                                labelStyle: TextStyle(color: Colors.white)),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter some text";
                              }
                            },
                          ),
                        ),
                        Container(
                          width: animation.value.width,
                          height: 100,
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.white)),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter some text";
                              }
                            },
                          ),
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : Container(
                                width: 250,
                                height: animation.value.height,
                                child: RaisedButton(
                                  onPressed: () {
                                    return submit().then((_) {
                                      setState(() {
                                        isLoading = !isLoading;
                                        emailController.clear();
                                        passwordController.clear();
                                      });
                                    });
                                  },
                                  child:
                                      page ? Text("Login") : Text("Register"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.white54,
                                  elevation: 10,
                                ),
                              ),
                        Divider(
                          height: 10,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )),
            ),
            FlatButton(
              child: Text(
                page ? "Create An Account" : "Login",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                animationController.reset();
                fadeanimationController.reset();
                animationController.forward();
                fadeanimationController.forward();
                setState(() {
                  page = !page;
                });
              },
            )
          ],
        ),
      )),
    );
  }

  Future<void> submit() async {
    if (formKey.currentState.validate()) {
      if (emailController.text.length != 0 ||
          passwordController.text.length != 0) {
        setState(() {
          isLoading = !isLoading;
        });
        try {
          if (page) {
            await Provider.of<authService>(context, listen: false).signIn(
                emailController.text.toString(),
                passwordController.text.toString());
          } else {
            await Provider.of<authService>(context, listen: false).signUp(
                emailController.text.toString(),
                passwordController.text.toString());
          }
          Navigator.of(context).pushReplacementNamed('WelcomeScreen');
        } catch (error) {
          showMessage(error.toString());
        }
      }
    } else {
      isLoading = !isLoading;
    }
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("An Error Occurred"),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ));
  }
}
