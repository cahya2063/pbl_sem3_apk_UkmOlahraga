import 'package:flutter/material.dart';
import 'package:pblukm/models/oprec.dart';

class oprecform2 {
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();
  final emailController = TextEditingController();
  final no_telpController = TextEditingController();
  final divisi_1Controller = TextEditingController();
  final divisi_2Controller = TextEditingController();

  oprecmodel convertToModel() {
    oprecmodel newoprec = oprecmodel(
      nama: this.namaController.text,
      nim: this.nimController.text,
      prodi: this.prodiController.text,
      email: this.emailController.text,
      no_telp: this.no_telpController.text,
      divisi_1: this.divisi_1Controller.text,
      // divisi_2: this.divisi_2Controller.text,
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
