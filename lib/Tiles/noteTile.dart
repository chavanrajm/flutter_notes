import 'package:flutter/material.dart';
import 'package:notes/Screens/noteEditScreen.dart';
import 'package:notes/note.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  VoidCallback callback;
  NoteTile({required this.note, required this.callback});
  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    widget.note.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                       IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder:(context)=>NoteEditScreen(note: widget.note,callback: widget.callback,)));
                        },
                      ),
                      SizedBox(width: 16.0),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey[600]),
                        onPressed: ()async{
                          await deleteNoteById(widget.note.id);
                          widget.callback();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.note.description,
                overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}