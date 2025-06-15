import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleNoteVew extends StatelessWidget {
  
  String title = "", time ="", description = "";
  Map? args;
  
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments != null ? (ModalRoute.of(context)!.settings.arguments as Map) : {};

    if(args!.isNotEmpty){
      title = args!['title'];
      description = args!['description'];
      int miliSeconds = int.parse(args!['time']);
      DateTime createdAt = DateTime.fromMicrosecondsSinceEpoch(miliSeconds);
      time = DateFormat('dd MMM yyy, hh:mm a').format(createdAt);
    }

    return Scaffold(
      appBar:  AppBar(
        title: Text("Notes", style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(11), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue
                ),
              ),
              Text(
                time,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  
                ),
              ),
              SizedBox(height: 24,),
              Text(
                description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}