import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pblukm/divisi.dart';
import 'package:pblukm/home.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/jadwal.dart';
import 'package:pblukm/profile.dart';

// ignore: camel_case_types
class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

// ignore: camel_case_types
class _navbarState extends State<navbar> {
  int _currentIndex = 0;
  bool isNavigationBarVisible = true;
  final List<Widget> _pages = [
    WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Home()),
    WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Jadwal()),
    //oprec(),
    WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Divisi()),
    //Divisi(),
    WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Profile()),
    //Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Visibility(
        visible: isNavigationBarVisible,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: FloatingNavbar(
            selectedBackgroundColor: Colors.transparent,
            borderRadius: 20,
            itemBorderRadius: 10,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            items: [
              FloatingNavbarItem(
                customWidget: Icon(
                  Iconsax.home_15,
                  size: 30,
                  color: _currentIndex == 0
                      ? const Color.fromARGB(255, 13, 41, 183)
                      : const Color.fromARGB(255, 223, 220, 251),
                ),
              ),
              FloatingNavbarItem(
                customWidget: Icon(
                  Iconsax.calendar_add5,
                  size: 30,
                  color: _currentIndex == 1
                      ? const Color.fromARGB(255, 13, 41, 183)
                      : const Color.fromARGB(255, 223, 220, 251),
                ),
              ),
              FloatingNavbarItem(
                customWidget: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Icon(
                    Iconsax.buildings5,
                    size: 30,
                    color: _currentIndex == 2
                        ? const Color.fromARGB(255, 13, 41, 183)
                        : const Color.fromARGB(255, 223, 220, 251),
                  ),
                ),
              ),
              FloatingNavbarItem(
                customWidget: Icon(
                  Icons.person_sharp,
                  size: 30,
                  color: _currentIndex == 3
                      ? const Color.fromARGB(255, 13, 41, 183)
                      : const Color.fromARGB(255, 223, 220, 251),
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;

                isNavigationBarVisible = true;
              });
            },
          ),
        ),
      ),
    );
  }
}
