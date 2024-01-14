import 'package:flutter/material.dart';
//import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/oprec.dart';

class oprecform2 {
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();

  final prodiController = TextEditingController();
  final no_telpController = TextEditingController();
  final divisi_1Controller = TextEditingController();
  final divisi_2Controller = TextEditingController();
  final semesterController = TextEditingController();

  oprecmodel convertToModel() {
    // emailController.text = formloginState.emailLogin;
    // nimController.text = formloginState.nimLogin;
    // prodiController.text = formloginState.prodiLogin;
    // namaController.text = formloginState.namaLogin;
    oprecmodel newoprec = oprecmodel(
      nama: namaController.text,
      nim: nimController.text,
      prodi: prodiController.text,
      email: emailController.text,
      no_telp: no_telpController.text,
      semester: semesterController.text,
      divisi_1: divisi_1Controller.text,
      divisi_2: divisi_2Controller.text,
    );

    //  nama: "coba",
    //     nim: "123",
    //     prodi: "trpl",
    //     email: "asd@gmail.com",
    //     no_telp: "123",
    //     divisi_1: "badminton");
    return newoprec;
  }
}
