import 'package:flutter/material.dart';
import 'package:ticket_support_system/firebase_services/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

//Yet to be implemented properly//

class Home extends StatefulWidget {

  Home({this.userId, this.auth, this.onSignedOut});

  final String userId;
  final VoidCallback onSignedOut;
  final FireBaseAuth auth;

  @override
  State<StatefulWidget> createState() => new HomePage();

}

class HomePage extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket System"),
      ),
      body: MyApp(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, icon: Icon(Icons.add), label: Text("Create Ticket"),),
    );
  }


  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppPage();
}

class MyAppPage extends State<MyApp> {

  String total_tickets;
  String open_tickets;
  String closed_tickets;
  final DocumentReference documentReference = Firestore.instance.document(
      'users/ayush');
  StreamSubscription<DocumentSnapshot> subscription;

  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          open_tickets = snapshot.data['open_tickets'].toString();
          closed_tickets = snapshot.data['closed_tickets'].toString();
          total_tickets =
              (int.parse(open_tickets) + int.parse(closed_tickets)).toString();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.blue.shade800,),
                child: ListTile(
                  title: Text("Total Tickets", style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600)),
                  trailing: Text(total_tickets.toString(), style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600)),
                  subtitle: Text("Total number of tickets that are created",
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.green,),
                child: ListTile(
                  title: Text("Open Tickets", style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600),),
                  trailing: Text(open_tickets.toString(), style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),),
                  subtitle: Text("Total number of tickets that are open",
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.red,),
                child: ListTile(
                  title: Text("Closed Tickets", style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600)),
                  trailing: Text(closed_tickets.toString(), style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),),
                  subtitle: Text("Total number of tickets that are closed",
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

