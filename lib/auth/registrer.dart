// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/auth/login.dart';
//import 'package:pblukm/form/oprecform2.dart';
import 'package:pblukm/models/Register.dart';
import 'package:pblukm/form/registerform.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<List<Registermodel>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/user/view'));
    if (response.statusCode == 200) {
      // Map<String, dynamic> responseBody = json.decode(response.body);
      // List<dynamic> divisiList = responseBody['data'];

      List<dynamic> responseBody = json.decode(response.body);
      List<dynamic> divisiList = responseBody.elementAt(0);

      List<Registermodel> oprec =
          divisiList.map((item) => Registermodel.fromjson(item)).toList();

      return oprec;
    } else {
      throw "Failed to load data: ${response.statusCode}";
    }
  }

  Future<void> regisApi(Registermodel regist) async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register'),
      body: jsonEncode(regist.toJson()), //json data
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var jsonresponse = jsonDecode(response.body);
      var message = jsonresponse['message'];
      print('register berhasil : $jsonresponse');
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              content: Text('Login yukk!!'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('OK')),
              ],
            );
          });
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
                        //teks continue to your account
                        const Padding(
                          padding: EdgeInsets.only(left: 30, top: 30),
                          child: Text(
                            'Nama',
                            style: TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15),
                          ),
                        ),
                        // text nama
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 20, top: 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'siapa namamu?';
                              }
                              return null;
                            },
                            controller: newreg.textName,
                            decoration: InputDecoration(
                              filled: false,
                              //fillColor: Color.fromARGB(104, 31, 65, 187),
                              hintText: 'Masukkan Nama',
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
                          ),
                        ),
                        //bagian input username
                        const Padding(
                          padding: EdgeInsets.only(left: 30, top: 0),
                          child: Text(
                            'Nim',
                            style: TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15),
                          ),
                        ),
                        // text nim
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 30, right: 30, left: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'mana nimmu?';
                                    }
                                    return null;
                                  },
                                  controller: newreg.textNim,
                                  // onSubmitted: (_) => newoprec.daftar(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    filled: false,
                                    //fillColor: Color.fromARGB(104, 31, 65, 187),
                                    hintText: 'Masukkan Nim',
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
                                ),
                              ),
                            ],
                          ),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 30, top: 0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15),
                          ),
                        ),
                        // text email
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 30, right: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'mana emailmu?';
                                    }
                                    return null;
                                  },
                                  controller: newreg.textEmail,
                                  // onSubmitted: (_) => newoprec.daftar(),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    filled: false,
                                    //fillColor: Color.fromARGB(104, 31, 65, 187),
                                    hintText: 'Masukkan Email',
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
                                ),
                              ),
                            ],
                          ),
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
                                    child: ElevatedButton(
                                      onPressed: () {
                                        print(newreg.textEmail);
                                        print(newreg.textName);
                                        print(newreg.textNim);
                                        print(newreg.textPass);
                                        print(newreg.textProdi);

                                        Registermodel dataBaru =
                                            newreg.convertToModel();
                                        regisApi(dataBaru);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: ((context) =>
                                        //         const formlogin()),
                                        //   ),
                                        // );
                                        //Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        shadowColor: const Color.fromARGB(
                                            255, 13, 41, 183),
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 13, 41, 183),
                                      ),
                                      child: const Text(
                                        'Create Account',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
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
}
