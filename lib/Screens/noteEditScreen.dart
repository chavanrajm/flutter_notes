import 'package:flutter/material.dart';
import 'package:notes/note.dart';

class NoteEditScreen extends StatefulWidget {
  Note note;
  VoidCallback callback;
  NoteEditScreen({required this.note, required this.callback});
  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _titleController.text = widget.note.title;
    _descriptionController.text = widget.note.description;
    super.initState();
  }
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
        title: Text('Edit Note'),
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
            widget.note.title = _titleController.text;
            widget.note.description = _descriptionController.text;
            updateNote(widget.note);
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