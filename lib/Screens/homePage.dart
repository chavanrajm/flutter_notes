import 'package:flutter/material.dart';
import 'package:notes/Screens/noteAddScreen.dart';
import 'package:notes/Screens/noteEditScreen.dart';
import 'package:notes/Tiles/noteTile.dart';
import 'package:notes/note.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var data;
  bool isDataFetched = false;
  void fetchData()async{
    data = await loadList();
   isDataFetched = true;
   setState(() {});
  }
  @override
void initState() {
    // TODO: implement initState
fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>NoteAddScreen(callback:(){fetchData();},)));
        },
          child: Icon(Icons.add,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:isDataFetched?Column(
            children: [
              if(data.isNotEmpty)for(Map d in data.reversed)NoteTile(note: Note(title: d['title'],description: d['description'],
              id: d['id']
              ),callback: (){fetchData();},)else Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text('Press + to add a note',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ):SizedBox()
        ),
      ),
    );
  }
}
