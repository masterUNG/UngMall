import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {

  // Field
  List<String> names = List();
  List<String> details = List();
  List<String> images = List();
  List<String> codes = List();

  // Method
  @override
  void initState(){
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore()async{

    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    await collectionReference.snapshots().listen((QuerySnapshot querySnapshot){
      List<DocumentSnapshot> snapshots = querySnapshot.documents;

      for (var snapshot in snapshots) {
        
        names.add(snapshot.data['Name']);
        details.add(snapshot.data['Detail']);
        images.add(snapshot.data['Image']);
        codes.add(snapshot.data['Code']);

        print('names[0] = ${names[0]}');

      }

    });

  }




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This is ShowList'),
    );
  }
}