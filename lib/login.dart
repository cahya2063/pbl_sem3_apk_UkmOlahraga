import 'package:flutter/material.dart';
import 'package:pblukm/loginform.dart';
import 'package:pblukm/navbar.dart';
import 'package:pblukm/registrer.dart';

// ignore: camel_case_types
class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Image.asset(
                'img/logoukm.png',
                width: 150,
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
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                      //teks welcome back!
                      const Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          'Continue to your account',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      //teks continue to your account
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Image.asset(
                          'img/poliwangi.png',
                          width: 175,
                        ),
                      ),
                      //logo poliwangi
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 50, left: 50),
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              const formlogin()),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                    ),
                                    child: const Text(
                                      'Login',
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
                      //tombol SSO login
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 50, left: 50),
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      foregroundColor: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              const Register()),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Daftar yuk!!',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                  ),
                                ),
                                //tombol SSO Poliwangi
                              ),
                            ),
                          ],
                        ),
                      ),
                      //tombol register
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Social Media',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      //teks social media
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 70,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.white,
                                        shadowColor: Colors.black,
                                        elevation: 10),
                                    onPressed: () {},
                                    child: Image.asset(
                                      'img/youtube.png',
                                      width: 50,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                height: 70,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.white,
                                        shadowColor: Colors.black,
                                        elevation: 10),
                                    onPressed: () {},
                                    child: Image.asset(
                                      'img/instagram.png',
                                      width: 50,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //tombol youtube dan instagram
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
