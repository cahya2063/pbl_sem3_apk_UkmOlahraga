import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:pblukm/loginform.dart';
import 'package:http/http.dart' as http;
//import 'package:pblukm/profile.dart';
import 'package:pblukm/models/usermodel.dart';
import 'package:pblukm/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProf extends StatefulWidget {
  const EditProf({super.key});

  @override
  State<EditProf> createState() => _EditProfState();
}

class _EditProfState extends State<EditProf> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? file;
  String filename = '';
  bool isCvUpload = false;
  final textEditEmail = TextEditingController();
  final textEditPass = TextEditingController();

  late User userLogin;
  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userLogin2 =
        User.fromjson2(json.decode(prefs.getString("UserLoginInfo")!));
    setState(() {
      userLogin = userLogin2;
      // print(userLogin.statuspendaftar);
      // print(userLogin.isAnggota);
      //print(recruitment);
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  //int? id = userLogin.iduserLogin;
  Future<void> editprof() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      // Tampilkan pesan jika form tidak valid
      return;
    }
if (file == null) {
      print('Tidak ada gambar yang dipilih');
      return;
    }

    // if (!isCvUpload) {
    //   return;
    // }
        String base64Image = base64Encode(file!.readAsBytesSync());
        String foto = base64Image;
    var url = Uri.parse(
        'http://10.0.2.2:8000/api/edit/profil/${userLogin.iduserLogin}');

    var response = await http.post(url, body: {
      'email': textEditEmail.text,
      'password': textEditPass.text,
      'gambar': foto,
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == true) {
        Navigator.pop(context, textEditEmail.text);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(data['message']),
              content: Text('harap logout dan login kembali'),
            );
          },
        );
        print(data['message']);
      } else {
        Navigator.pop(context, textEditEmail.text);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('failed'),
              content: Text('gagal update profile'),
            );
          },
        );
        print('gagal update data');
      }
    } else {
      throw "gagal update profile ${response.statusCode}";
    }
  }

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 50),
              child: Text(
                'Edit Profile',
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
                  padding: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 50),
                                child: Container(
                                  // Sesuaikan tinggi Container agar cukup besar
                                  height: 300, // Ubah tinggi sesuai kebutuhan
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 20,
                                    ), // Ubah padding sesuai kebutuhan
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              textFieldEditProf(
                                                  judul: 'gmail',
                                                  validasi: 'mana emailmu?',
                                                  hintext: userLogin.emailLogin,
                                                  controller: textEditEmail),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              textFieldEditProf(
                                                  judul: 'password',
                                                  validasi: 'mana passwordmu?',
                                                  hintext:
                                                      'masukkan password baru',
                                                  controller: textEditPass),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 2,
                                                      child: Text('foto')),
                                                  const Expanded(
                                                      flex: 0,
                                                      child: Text(
                                                        ':',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          width: 0.0,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          //========

                                                          filename != null
                                                              ? Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Text(
                                                                      filename,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          overflow:
                                                                              TextOverflow.ellipsis),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  child: Text(
                                                                    'gambar cv',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 5),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                fromGallery();
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        155,
                                                                        187,
                                                                        252),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                'choose file',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  editprof();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor:
                                                        const Color(
                                                            0xff4741A6)),
                                                child: const Text(
                                                    'perbarui profile')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor:
                                                        const Color(
                                                            0xff7A7A7A)),
                                                child: const Text('batal')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future fromGallery() async {
    // ignore: non_constant_identifier_names
    final PickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery); //mengambil gambar dari source galeri
    if (PickedFile != null) {
      setState(() {
        file = File(PickedFile.path); //mengambil gambar
        filename = file!.path.split('/').last; //mengambil nama file dari path
      });
    } else {
      setState(() {
        'tidak ada gambar dipilih';
      });
    }
  }
}
