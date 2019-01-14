import 'package:flutter/material.dart';
import 'package:ticket_support_system/firebase_services/firebase_auth.dart';

class Home extends StatefulWidget{

  Home({this.userId,this.auth,this.onSignedOut});
  final String userId;
  final VoidCallback onSignedOut;
  final FireBaseAuth auth;

  @override
  State<StatefulWidget> createState() => new HomePage();

}

class HomePage extends State<Home>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: MaterialButton(onPressed: _signOut,child: Text("SignOut"),)
      ),
    );
  }

  _signOut()async{
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e){
      print(e);
    }
  }
}

