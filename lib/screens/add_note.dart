import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelearn/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  User user;

  AddNoteScreen(this.user);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: titleCont,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Descrption:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                minLines: 5,
                maxLines: 10,
                controller: descCont,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (titleCont.text == '' || descCont.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('All fields required'),
                            ));
                          } else {
                            setState(() {
                              isLoading = true;
                            });

                            await FirestoreService().insertNote(
                                titleCont.text, descCont.text, widget.user.uid);
                            setState(() {
                              isLoading = true;
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Add Note',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
