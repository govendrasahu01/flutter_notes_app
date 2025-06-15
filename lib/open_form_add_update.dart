import 'package:db_sqlite/db_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OpenForm extends StatefulWidget {
  String formTitle;
  String titleValue;
  String descriptionValue;
  int? noteId;
  VoidCallback fetchAllNote;


  OpenForm({
    required this.formTitle, 
    required this.fetchAllNote, 
    this.titleValue="", 
    this.noteId, 
    this.descriptionValue="",  
    super.key
  });

  @override
  State<OpenForm> createState() => _OpenFormState();
}

class _OpenFormState extends State<OpenForm> {
  var descriptionController; 
  var titleController;

  @override void initState() {
    descriptionController = TextEditingController(text: widget.descriptionValue);
    titleController = TextEditingController(text: widget.titleValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          // height: 400,
          padding: EdgeInsets.all(11),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${widget.formTitle} Note",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              SizedBox(height: 11,),
              TextField(
                controller: titleController,
                
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 11,),
              TextField(
                controller: descriptionController,
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: (){ Navigator.pop(context);},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.red)
                    ),
                    child: Text("Cancel")
                  ),
                  SizedBox(width: 11,),
                  OutlinedButton(
                    onPressed: ()async{
                      var dbHelper = DBHelper.getInstance();
                      if(widget.noteId == null){
                        await dbHelper.addNote(
                          title: titleController.text, 
                          description: descriptionController.text
                        );
                      }else{
                        await dbHelper.updateNote(
                          id: widget.noteId!, 
                          title: titleController.text, 
                          description: descriptionController.text
                        );
                      }
                      widget.fetchAllNote();
                      Navigator.pop(context);
                    }, 
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.blue)
                    ),
                    child: Text("Save")
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}