import 'package:firelearn/models/note_model.dart';
import 'package:firelearn/services/firestore_service.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  NoteModel note;
  EditNote(this.note);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    titleCont.text = widget.note.title;
    descCont.text = widget.note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Please Confirm'),
                        content: Text('Are you sure to delete this note ? '),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await FirestoreService()
                                  .deleteNote(widget.note.id);

                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    });
              })
        ],
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
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
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

                            await FirestoreService().updateNote(
                              widget.note.id,
                              titleCont.text,
                              descCont.text,
                            );
                            setState(() {
                              isLoading = true;
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Edit Note',
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
