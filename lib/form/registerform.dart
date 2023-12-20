import 'package:flutter/material.dart';
import 'package:pblukm/models/Register.dart';

class registerform{
  //name nim prodi email
  final textName = TextEditingController();
  final textNim = TextEditingController();
  final textProdi = TextEditingController();
  final textEmail = TextEditingController();
  final textPass = TextEditingController();

  Registermodel convertToModel(){
    Registermodel newRegister = Registermodel(
      name: textName.text,
      nim: textNim.text,
      prodi: textProdi.text,
      email: textEmail.text,
      password: textPass.text,
    );
    return newRegister;
  }
}