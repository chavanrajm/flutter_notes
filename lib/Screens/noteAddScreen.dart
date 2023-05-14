import 'package:flutter/material.dart';
import 'package:notes/note.dart';
import 'package:uuid/uuid.dart';

class NoteAddScreen extends StatefulWidget {
  VoidCallback callback;
  NoteAddScreen({required this.callback});
  @override
  _NoteAddScreenState createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(_titleController.text.isNotEmpty&&_descriptionController.text.isNotEmpty){
            String title = _titleController.text;
            String description = _descriptionController.text;
            Note newNote = Note(title: title, description: description, id:Uuid().v1());
            await createNote(newNote);
            widget.callback();
            Navigator.pop(context);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please Fill All Fields"),
            ));
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}