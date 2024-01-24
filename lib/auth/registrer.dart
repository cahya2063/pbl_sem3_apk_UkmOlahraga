// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/models/Register.dart';
import 'package:pblukm/form/registerform.dart';
import 'package:http/http.dart' as http;
import 'package:pblukm/widget/widget.dart';

// ignore: camel_case_types
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  Future<void> regisApi(Registermodel regist) async {
    bool isValid = formKey.currentState!.validate();//validator
    if (!isValid) {
      return;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'//untuk memberi tahu server bahwa request yang dikirim berupa json
      },
      body: jsonEncode(regist.toJson()), //masukkan data yang ada pada regist.toJson ke bodiy dari API
    );
    if (response.statusCode == 200) {
      var jsonresponse = jsonDecode(response.body);//ubah respons json dan masukkan ke jsonresponse
      var message = jsonresponse['message'];//dan masukkan jsonresponse['message] ke message
      print('status pendaftar : $jsonresponse');
      if (jsonresponse['status'] == true) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(message),
                content: Text('Login yukk!!'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK')),
                ],
              );
            });
      } else {
        //Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(message),
                //content: Text('Login yukk!!'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK')),
                ],
              );
            });
      }
    } else {
      print(response.body);
      throw "Failed to add data ${response.statusCode}";
    }
  }

  registerform newreg = registerform();
  bool obscuretext = true;
  List<String> jurusan = ['TRM', 'JBI', 'AGB', 'MBP', 'TPHT', 'sipil'];
  String selectjr = 'sipil';
  @override
  Widget build(BuildContext context) {
    newreg.textProdi.text = selectjr;
    return Scaffold(
      backgroundColor: Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Iconsax.arrow_left_2)),
            ),
            //tombol back
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Image.asset(
                  'img/logoukm.png',
                  width: 150,
                ),
              ),
            ),
            //logo ukm
            Expanded(
              child: Container(
                height: 500,
                width: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                //white container
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text(
                              "Let's Get Started!",
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                        //teks welcome back!
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Center(
                            child: Text(
                              'Create a new account',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 20, top: 0),
                          child: textFieldAuth(
                            validasi: 'siapa namamu?',
                            hinText: 'Masukkan Nama',
                            controller: newreg.textName,
                            judul: 'nama',
                            tipe: TextInputType.text,
                          ),
                        ),
                        //bagian input username
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30, top: 0, right: 30, bottom: 30),
                          child: textFieldAuth(
                              validasi: 'mana nim mu?',
                              hinText: 'masukkan mim',
                              controller: newreg.textNim,
                              judul: 'nim',
                              tipe: TextInputType.number),
                        ),
                        //input NIM
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 30, right: 30),
                          child: DropdownButtonFormField<String>(
                            value: selectjr,
                            onChanged: (newvalue) {
                              setState(() {
                                selectjr = newvalue!;
                                newreg.textProdi.text = selectjr;
                              });
                            },
                            decoration: InputDecoration(
                              filled: false,
                              //fillColor: Color.fromARGB(104, 31, 65, 187),
                              labelText: 'jurusanmu!',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            items: jurusan
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ));
                            }).toList(),
                          ),
                        ),
                        //dropdown prodi
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30, top: 0, right: 30, bottom: 20),
                          child: textFieldAuth(
                              validasi: 'mana emailmu?',
                              hinText: 'masukkan email',
                              controller: newreg.textEmail,
                              judul: 'email',
                              tipe: TextInputType.emailAddress),
                        ),
                        //input email
                        const Padding(
                          padding: EdgeInsets.only(left: 30, top: 0),
                          child: Text(
                            'Password',
                            style: TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15),
                          ),
                        ),
                        // text nama
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 0, bottom: 30),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'mana passwordmu?';
                              }
                              return null;
                            },
                            controller: newreg.textPass,
                            obscureText: obscuretext,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscuretext = !obscuretext;
                                  });
                                },
                                child: Icon(obscuretext
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash),
                              ),
                              hintText: 'Masukkan Password',
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        //bagian input password
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50, left: 50),
                                  child: SizedBox(
                                    height: 60,
                                    child: button(text: 'Create Account', pressed: send)
                                  ),
                                  //tombol SSO Poliwangi
                                ),
                              ),
                            ],
                          ),
                        ),
                        //tombol create account
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

  send() {
    // print(newreg.textName.text);
    // print(newreg.textNim.text);
    // print(newreg.textProdi.text);
    // print(newreg.textEmail.text);
    // print(newreg.textPass.text);
    Registermodel dataBaru = newreg.convertToModel();
    regisApi(dataBaru);
  }
}
