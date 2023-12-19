import 'package:flutter/material.dart';
import 'package:pblukm/models/oprec.dart';

class oprecform extends StatefulWidget {
  final Function(oprecmodel) addOprec;
  const oprecform(this.addOprec, {super.key});

  @override
  State<oprecform> createState() => oprecformState();
}

class oprecformState extends State<oprecform> {
  @override
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();
  final emailController = TextEditingController();
  final no_telpController = TextEditingController();
  final divisi_1Controller = TextEditingController();
  final divisi_2Controller = TextEditingController();


  void daftar() {
    final enterednama = namaController.text;
    final enterednim = nimController.text;
    final enteredprodi = prodiController.text;
    final enteredemail = emailController.text;
    final enterednoTelp = no_telpController.text;
    final entereddivisi1 = divisi_1Controller.text;
    final entereddivisi2 = divisi_2Controller.text;

    if (enterednama.isEmpty ||
        enterednim.isEmpty ||
        enteredprodi.isEmpty ||
        enteredemail.isEmpty ||
        enterednoTelp.isEmpty ||
        entereddivisi1.isEmpty ||
        entereddivisi2.isEmpty) {
          return;
        }
    final oprecmodel newoprec = oprecmodel(
      nama: enterednama,
      nim: enterednim,
      prodi: enteredprodi,
      email: enteredemail,
      no_telp: enterednoTelp,
      divisi_1: entereddivisi1,
      divisi_2: entereddivisi2,
    );
    widget.addOprec(newoprec);
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
