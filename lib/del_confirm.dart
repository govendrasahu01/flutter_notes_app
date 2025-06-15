import 'package:db_sqlite/db_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DelConfirm extends StatelessWidget {
  int noteId;
  String noteTitle;
  VoidCallback fetchAllNotes;

  DelConfirm({
    required this.noteId, 
    required this.noteTitle, 
    required this.fetchAllNotes, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.all(11),
      child: Column(
        children: [
          Text("Do you really want to delete?", style: TextStyle(
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),),
          Text("($noteTitle)", style: TextStyle(
            fontSize: 17,
            color: Colors.blueGrey.shade400,
            fontWeight: FontWeight.w500,
          ),),
          SizedBox(height: 11,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: (){
                    Navigator.pop(context);
                }, 
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.green)
                ),
                child: Text("Cancel")
              ),
              
              SizedBox(width: 11,),
              
              OutlinedButton(
                onPressed: ()async{
                  DBHelper dbHelper = DBHelper.getInstance();
                  bool isDeleted = await dbHelper.deleteNote(id: noteId);
                  if(isDeleted){
                    fetchAllNotes();
                  }
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.red)
                ),
                child: Text("Confirm")
              ),
            ],
          ),
        ],
      ),
    );
  }
}