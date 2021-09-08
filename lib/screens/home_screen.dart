import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelearn/models/note_model.dart';
import 'package:firelearn/screens/add_note.dart';
import 'package:firelearn/screens/edit_note.dart';
import 'package:firelearn/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  User user;

  HomeScreen(this.user);
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .where('userId', isEqualTo: user.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  NoteModel note =
                      NoteModel.fromJson(snapshot.data.docs[index]);

                  return Card(
                    color: Colors.orange[100],
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      title: Text(
                        note.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      subtitle: Text(
                        note.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditNote(note),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No notes availabe'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(user),
            ),
          );
        },
      ),
    );
  }
}

/*


 Card(
              color: Colors.orange[100],
              elevation: 3,
              margin: EdgeInsets.all(10),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                title: Text(
                  'Builad a new app',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                subtitle: Text(
                  'This is just a sample of the subtitle her you can see wonderflull things ',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditNote(),
                    ),
                  );
                },
              ),
            )

 */
