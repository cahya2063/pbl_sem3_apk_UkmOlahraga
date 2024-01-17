// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class textFieldAuth extends StatelessWidget {
  textFieldAuth(
      {required this.validasi,
      required this.hinText,
      required this.controller,
      required this.judul,
      required this.tipe});
  String validasi, hinText, judul;
  TextInputType tipe;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 15),
        ),
        TextFormField(
          keyboardType: tipe,
          validator: (value) {
            if (value!.isEmpty) {
              return validasi;
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            filled: false,
            //fillColor: Color.fromARGB(104, 31, 65, 187),
            hintText: hinText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}

class button extends StatelessWidget {
  button({super.key, required this.text, required this.pressed, this.bgColor});

  final String text;
  final Function()? pressed;
  Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
            shadowColor: const Color.fromARGB(255, 13, 41, 183),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: bgColor ?? Color.fromARGB(255, 13, 41, 183)),
        child: Text(
          text,
          style: TextStyle(fontSize: 22),
        ));
  }
}

class textFieldPendaftaran extends StatelessWidget {
  //const textFieldPendaftaran({super.key});
  textFieldPendaftaran(
      {required this.controller,
      required this.hinText,
      required this.tipe,
      required this.judul,
      required this.valid,
      this.noHp,
      required this.read});
  TextEditingController controller = TextEditingController();
  TextInputType tipe;
  String hinText, judul;
  String? noHp;
  bool read;
  String? Function(String?) valid;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 15),
        ),
        TextFormField(
          readOnly: read ?? true,
          controller: controller,
          validator: valid,
          // onSubmitted: (_) => newoprec.daftar(),
          keyboardType: tipe,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            filled: false,
            hintText: hinText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                )),
            hintStyle: const TextStyle(fontFamily: 'Poppins'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class buttonHome extends StatelessWidget {
  //const buttonHome({super.key});
  buttonHome(
      {required this.iconsPicked,
      required this.iconColor,
      required this.pressed,
      required this.textButton});
  IconData iconsPicked;
  Color iconColor;
  String textButton;
  final Function()? pressed;
  @override
  Widget build(BuildContext context) {
    //var iconsPicked;
    return ElevatedButton(
      onPressed: pressed,
      style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.blue, width: 2),
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          elevation: 10,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconsPicked,
            size: 50,
            color: iconColor,
          ),
          Text(
            textButton,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
