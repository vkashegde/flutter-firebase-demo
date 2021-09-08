import 'package:firelearn/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  //instence
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.pink[25],
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await AuthService().signOut();
              })
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  //collection reference
                  CollectionReference users = firestore.collection('users');

                  //insertdata
                  await users.add({'name': 'Vikas 3'});

                  /*

                  adding own doc ids 
                  await users.doc('docid').set({
                    'name':'vikas'
                  })
                  */
                },
                child: Text('Add Data to Firestore')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  CollectionReference users = firestore.collection('users');

                  //read data
                  QuerySnapshot allRes = await users.get();
                  allRes.docs.forEach((DocumentSnapshot result) {
                    print(result.data());
                  });

                  /*
                  read with doc id
                  Documentsnapshot res = await users.doc('docid).get();
                  print(res.data());
                   */

                  /* listen to realtime stream 
                  users.doc('docid').snapshots().listen((res){

                    print(res.data());
                  });
                  
                  
                  */
                },
                child: Text('Read data')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await firestore
                      .collection('users')
                      .doc('docid')
                      .update({'name': "Vishal"});

                  //delete data
                  //await firestore.collection('users').doc('docid').delete();
                },
                child: Text('Update data'))
          ],
        ),
      ),
    );
  }
}
