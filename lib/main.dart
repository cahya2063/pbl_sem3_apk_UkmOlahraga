import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pblukm/divisi/fiturdiv.dart';
//import 'package:pblukm/home.dart';
//import 'package:pblukm/home.dart';
import 'package:pblukm/auth/login.dart';
import 'package:pblukm/models/usermodel.dart';
import 'package:pblukm/home/navbar.dart';
import 'package:pblukm/transaksi/stok.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("UserLoginInfo");
  print(email);
  runApp(MaterialApp(
     routes: {
       // '/home':(context) => Home(),
        '/stok':(context) => Stok(),
        '/futsal': (context) => const Futsal(),
        '/basket': (context) => const Basket(),
        '/badminthon': (context) => const Badminthon(),
        '/tarungderajat': (context) => const Tarungderajat(),
        '/volly': (context) => const Volly(),
        '/silat': (context) => const Silat(),
        '/tenismeja': (context) => const Tenismeja(),
        '/karate': (context) => const Karate(),
        '/esport': (context) => const E_sport(),
        '/catur': (context) => const Catur(),
        '/taekwondo': (context) => const Taekwondo(),
      },
      debugShowCheckedModeBanner: false,
     theme: ThemeData(fontFamily: 'Poppins'),
    
    home: email==null?login():navbar(),));
}


