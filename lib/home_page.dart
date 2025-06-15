import 'package:db_sqlite/db_helper.dart';
import 'package:db_sqlite/note_list.dart';
import 'package:db_sqlite/open_form_add_update.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbHelper;

  @override void initState() {
    dbHelper = DBHelper.getInstance();
    fetchAllNotes();
    super.initState();
  }

  void fetchAllNotes() async{
    allNotes = await dbHelper!.getAllNotes();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Notes", style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.blueAccent,
      ),
      
      body: NoteList(allNotes: allNotes, fetchAllNotes: fetchAllNotes,),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_){
              return OpenForm(formTitle: "Add", fetchAllNote: fetchAllNotes,);
            }
          );
        }, 
        child: Icon(Icons.add),
      ),
    );
  }
}


