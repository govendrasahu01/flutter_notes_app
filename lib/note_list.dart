import 'package:db_sqlite/db_helper.dart';
import 'package:db_sqlite/del_confirm.dart';
import 'package:db_sqlite/main.dart';
import 'package:db_sqlite/open_form_add_update.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NoteList extends StatelessWidget{
  List<Map<String,dynamic>> allNotes = [];
  final VoidCallback fetchAllNotes;

  NoteList({super.key, required this.allNotes,required this.fetchAllNotes});

  @override
  Widget build(BuildContext context) {
    if(allNotes.isEmpty ){
      return Center(child: Text(
        "Create Our Fist Note",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.blueGrey
        ),
      ),);
    }
    else{
      return GridView.builder(
        itemCount: allNotes.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3/4,
        ), 
        itemBuilder: (_, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // elevation: ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allNotes[index][DBHelper.columnNoteTitle]!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.blue,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      getFormatedDate(allNotes[index][DBHelper.columnCreatedAt]!),
                      style: TextStyle(
                        color: Colors.brown
                      ),
                    ),
                    SizedBox(height: 11,),
                    Text(
                      allNotes[index][DBHelper.columnNoteDesc]!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
      
                    SizedBox(height: 11,),
                    Expanded(child: Container()),
      
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: (){
                              Navigator.pushNamed(
                                context, 
                                AppRoutes.singleNoteView, 
                                arguments: {
                                  "title": allNotes[index][DBHelper.columnNoteTitle]!,
                                  "time":allNotes[index][DBHelper.columnCreatedAt]!,
                                  "description":allNotes[index][DBHelper.columnNoteDesc]!,
                                }
                              );
                            }, 
                            icon: Icon(Icons.visibility),
                          ),
                          IconButton(
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () async {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_){
                                  return OpenForm(
                                    formTitle: "Upadate", fetchAllNote: fetchAllNotes, 
                                    titleValue: allNotes[index][DBHelper.columnNoteTitle]!,
                                    descriptionValue: allNotes[index][DBHelper.columnNoteDesc]!,
                                    noteId: allNotes[index][DBHelper.columnNoteId]!,
                                  );
                                }
                              );
                            },
                            icon: Icon(Icons.edit)
                          ),
                          IconButton(
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: ()async{
                              showModalBottomSheet(context: context, builder: (_){
                                return DelConfirm(
                                  noteId: allNotes[index][DBHelper.columnNoteId]!,
                                  noteTitle: allNotes[index][DBHelper.columnNoteTitle]!,
                                  fetchAllNotes: fetchAllNotes,
                                );
                              });
                              
                            }, 
                            icon: Icon(Icons.delete)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      );
    }
      
  }
}

String getFormatedDate(milisecond){
  int ms = int.parse(milisecond);
  DateTime date = DateTime.fromMicrosecondsSinceEpoch(ms);
  String formatedDate = DateFormat('dd MMM yyy').format(date);
  return formatedDate;
}