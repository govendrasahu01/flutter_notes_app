import 'package:db_sqlite/home_page.dart';
import 'package:db_sqlite/single_note_vew.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HomePage(),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}

class AppRoutes {
  static final String home = '/';
  static final String singleNoteView = '/noteDetail';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (_)=>HomePage(),
    singleNoteView: (_)=>SingleNoteVew()
  };

}