import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungmall/utility/my_style.dart';
import 'package:ungmall/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  String name, email, password;
  final formKey = GlobalKey<FormState>();

  // Method
  Widget nameForm() {
    Color color = Colors.deepOrange;
    return TextFormField(
      onSaved: (String string) {
        name = string.trim();
      },
      decoration: InputDecoration(
        hintText: 'English Only',
        helperText: 'Please Type Your Name in Blank',
        helperStyle: TextStyle(color: color),
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: color),
        icon: Icon(
          Icons.account_box,
          size: 36.0,
          color: color,
        ),
      ),
    );
  }

  Widget emailForm() {
    Color color = Colors.blueAccent.shade700;
    return TextFormField(
      onSaved: (String string) {
        email = string.trim();
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'you@mail.com',
        helperText: 'Please Type Your Email in Blank',
        helperStyle: TextStyle(color: color),
        labelText: 'Email :',
        labelStyle: TextStyle(color: color),
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: color,
        ),
      ),
    );
  }

  Widget passwordForm() {
    Color color = Colors.greenAccent.shade700;
    return TextFormField(
      onSaved: (String string) {
        password = string.trim();
      },
      decoration: InputDecoration(
        hintText: 'More 6 Charactor',
        helperText: 'Please Type Your Password in Blank',
        helperStyle: TextStyle(color: color),
        labelText: 'Password :',
        labelStyle: TextStyle(color: color),
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: color,
        ),
      ),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        formKey.currentState.save();
        print('name = $name, email = $email, password = $password');
        registerThread();
      },
    );
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      print('title = $title, message = $message');
      normalDialog(context, title, message);
    });
  }

  Future<void> setupDisplayName()async{

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    firebaseUser.updateProfile(userUpdateInfo);

    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().textColor,
        actions: <Widget>[registerButton()],
        title: Text('Register'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [Colors.white, MyStyle().mainColor],
              radius: 1.2,
              center: AlignmentDirectional(0, -0.5)),
        ),
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(40.0),
            children: <Widget>[
              nameForm(),
              emailForm(),
              passwordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
