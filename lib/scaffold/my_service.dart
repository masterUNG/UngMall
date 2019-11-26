import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungmall/utility/my_style.dart';
import 'package:ungmall/utility/normal_dialog.dart';
import 'package:ungmall/widget/show_list.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Field
  String loginString = '...';
  Widget currentWidget = ShowList();

  // Method
  Widget menuShowList() {
    return ListTile(
      leading: Icon(
        Icons.filter_1,
        size: 36.0,
      ),
      title: Text('Show List'),
      subtitle: Text('Show List From Firestore'),
      onTap: (){},
    );
  }

  Widget menuQRcode() {
    return ListTile(
      leading: Icon(
        Icons.filter_3,
        size: 36.0,
      ),
      title: Text('QR code'),
      subtitle: Text('Read QR code or Bar Code'),
      onTap: (){
        Navigator.of(context).pop();
        readQRthread();
      },
    );
  }

  Future<void> readQRthread()async{

    try {

      String codeReaded = await BarcodeScanner.scan();

      if (codeReaded != null) {
        normalDialog(context, 'Code Readed', 'Code = $codeReaded');
      } else {
        normalDialog(context, 'Code Readed', 'Cannot Read');
      }

      
    } catch (e) {
    }

  }

  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      loginString = firebaseUser.displayName;
    });
    print('login = $loginString');
  }

  Widget showLogin() {
    return Text('Login by $loginString');
  }

  Widget showAppName() {
    return Text('Ung Mall');
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget headDrawer() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          headDrawer(),menuShowList(),menuQRcode(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().textColor,
        title: Text('My Service'),
      ),
      body: currentWidget,
      drawer: showDrawer(),
    );
  }
}
