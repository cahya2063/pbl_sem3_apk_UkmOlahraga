import 'package:flutter/material.dart';
import 'package:pblukm/fiturdiv.dart';
import 'package:pblukm/login.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/futsal':(context) => Futsal(),
        '/basket':(context) => Basket(),
        '/badminthon':(context) => Badminthon(),
        '/tarungderajat':(context) => Tarungderajat(),
        '/volly':(context) => Volly(),
        '/silat':(context) => Silat(),
        '/tenismeja':(context) => Tenismeja(),
        '/karate':(context) => Karate(),
        '/esport':(context) => E_sport(),
        '/catur':(context) => Catur(),
        '/taekwondo':(context) => Taekwondo(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: login(),
        ),
      ),
    );
  }
}
