import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/navbar.dart';

// ignore: camel_case_types
class formlogin extends StatefulWidget {
  const formlogin({super.key});

  @override
  State<formlogin> createState() => _formloginState();
}

// ignore: camel_case_types
class _formloginState extends State<formlogin> {
  bool obscuretext = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                  padding: const EdgeInsets.only(top: 0, bottom: 20),
                  child: Image.asset(
                    'img/logoukm.png',
                    width: 150,
                  ),
                ),
              ),
              //logo ukm
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  //white container
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Welcome Back!',
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                        // teks welcome ack
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Text(
                            'Continue to your account',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        //teks continue to your account
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 30, top: 30),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: false,
                              //fillColor: Color.fromARGB(104, 31, 65, 187),
                              hintText: 'username sesuai SSO',
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
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 0, bottom: 30),
                          child: TextField(
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
                              hintText: 'Password SSO',
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
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 50, left: 50),
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        // ketika diklik, nanti response dari api
                                        // response nya berupa token / id user.
                                        // atau berupa objek user
                                        // objek tersebut bisa di simpan di shared preferense

                                        //response status menunggu, kirim ke halaman tunggu
                                        // klo diterima kasih ke home

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const navbar())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shadowColor: const Color.fromARGB(
                                              255, 13, 41, 183),
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          backgroundColor: const Color.fromARGB(
                                              255, 13, 41, 183)),
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(fontSize: 22),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //tombol Sign In
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
