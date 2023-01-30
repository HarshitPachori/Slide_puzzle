import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_puzzle/board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter Demo',
       theme: ThemeData(
         primarySwatch: Colors.grey,
         fontFamily: GoogleFonts.roboto().fontFamily
       ),
        home:   const Board());
  }
}
