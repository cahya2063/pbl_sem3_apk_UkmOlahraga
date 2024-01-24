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

class blueButton extends StatelessWidget {
  //const blueButton({super.key});
  blueButton(
      {required this.action,
      this.height,
      this.left,
      this.right,
      this.radius,
      this.bgColor,
      this.fontSize,
      required this.textMid});
  final Function()? action;
  Color? bgColor;
  String textMid;
  double? fontSize;
  double? height;
  double? left, right;
  double? radius;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: left ?? 50, right: right ?? 50),
            child: SizedBox(
              height: height,
              child: ElevatedButton(
                  onPressed: action,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          bgColor ?? Color.fromARGB(255, 13, 41, 183),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius ?? 15))),
                  child: Text(
                    textMid,
                    style: TextStyle(fontSize: fontSize ?? 20),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class anggotaDivisi extends StatelessWidget {
  //const anggotaDivisi({super.key});
  anggotaDivisi(
      {required this.dataAnggota,
      this.top,
      required this.namaDivisi,
      required this.pathGambar});
  List<dynamic> dataAnggota = [];
  double? top;
  String namaDivisi, pathGambar;
  @override
  Widget build(BuildContext context) {
    //fetchData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Iconsax.arrow_left_2,
              color: Colors.black,
            )),
      ),
      backgroundColor: const Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0, bottom: 50),
              child: Text(
                namaDivisi,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 50),
              ),
            ),
            Expanded(
              child: Container(
                height: 500,
                width: 500,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20, top: top ?? 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            pathGambar,
                            width: 250,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          '- anggota -',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.blue, width: 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 3,
                                        blurRadius: 5)
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Nama',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      Text(
                                        'Prodi',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: dataAnggota.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          //border: Border.all(color: Colors.blue),

                                          //borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  dataAnggota[index]['nama'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 10,
                                                  )),
                                              Text(
                                                dataAnggota[index]['prodi'],
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class textFieldEditProf extends StatelessWidget {
  textFieldEditProf(
      {required this.judul,
      required this.validasi,
      required this.hintext,
      required this.controller});

  String judul;
  String validasi;
  String hintext;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(judul)),
        const Expanded(
            flex: 0,
            child: Text(
              ':',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
        const SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return validasi;
              }
              return null;
            },
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: hintext,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        ),
      ],
    );
  }
}
