import 'package:flutter/material.dart';
import 'package:pblukm/fiturdiv.dart';
import 'package:pblukm/login.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/futsal':(context) =>const Futsal(),
        '/basket':(context) =>const Basket(),
        '/badminthon':(context) =>const Badminthon(),
        '/tarungderajat':(context) =>const Tarungderajat(),
        '/volly':(context) =>const Volly(),
        '/silat':(context) =>const Silat(),
        '/tenismeja':(context) =>const Tenismeja(),
        '/karate':(context) =>const Karate(),
        '/esport':(context) =>const E_sport(),
        '/catur':(context) =>const Catur(),
        '/taekwondo':(context) =>const Taekwondo(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          body: login(),
        ),
      ),
    );
  }
}
