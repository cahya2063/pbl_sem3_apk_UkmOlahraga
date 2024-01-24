import 'package:flutter/material.dart';
//import 'package:pblukm/models/oprec.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pblukm/widget/widget.dart';

class Futsal extends StatefulWidget {
  const Futsal({super.key});

  @override
  State<Futsal> createState() => _FutsalState();
}

class _FutsalState extends State<Futsal> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Futsal/Futsal')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    //fetchData();
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Futsal',
        pathGambar: 'divisi/futsal.png');
  }
}
//fitur div futsal

class Badminthon extends StatefulWidget {
  const Badminthon({super.key});

  @override
  State<Badminthon> createState() => _BadminthonState();
}

class _BadminthonState extends State<Badminthon> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Badminton/Badminton')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Badminton',
        pathGambar: 'divisi/badminton 1.png');
  }
}
//fitur div badminthon

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Basket/Basket')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Basket',
        pathGambar: 'divisi/basket.png');
  }
}
//fitur div basket

class Volly extends StatefulWidget {
  const Volly({super.key});

  @override
  State<Volly> createState() => _VollyState();
}

class _VollyState extends State<Volly> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Volly/Volly')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        top: 20,
        dataAnggota: dataAnggota,
        namaDivisi: 'Volly',
        pathGambar: 'divisi/voli.png');
  }
}
//fitur div volly

class Silat extends StatefulWidget {
  const Silat({super.key});

  @override
  State<Silat> createState() => _SilatState();
}

class _SilatState extends State<Silat> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Silat/Silat')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        top: 20,
        dataAnggota: dataAnggota,
        namaDivisi: 'Silat',
        pathGambar: 'divisi/silat.png');
  }
}

//fitur div Silat
class Tenismeja extends StatefulWidget {
  const Tenismeja({super.key});

  @override
  State<Tenismeja> createState() => _TenismejaState();
}

class _TenismejaState extends State<Tenismeja> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Tenis meja/Tenis meja')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Tenis meja',
        pathGambar: 'divisi/tenismeja.png');
  }
}
//fitur div Tenismeja

class Karate extends StatefulWidget {
  const Karate({super.key});

  @override
  State<Karate> createState() => _KarateState();
}

class _KarateState extends State<Karate> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Karate/Karate')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Karate',
        pathGambar: 'divisi/karate.png');
  }
}
//fitur div Karate

// ignore: camel_case_types
class E_sport extends StatefulWidget {
  const E_sport({super.key});

  @override
  State<E_sport> createState() => _E_sportState();
}

// ignore: camel_case_types
class _E_sportState extends State<E_sport> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/E-sport/E-sport')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'E-Sport',
        pathGambar: 'divisi/esport.png');
  }
}

//fitur div E_sport
class Catur extends StatefulWidget {
  const Catur({super.key});

  @override
  State<Catur> createState() => _CaturState();
}

class _CaturState extends State<Catur> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Catur/Catur')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Catur',
        pathGambar: 'divisi/catur.png');
  }
}
//fitur div Catur

class Tarungderajat extends StatefulWidget {
  const Tarungderajat({super.key});

  @override
  State<Tarungderajat> createState() => _TarungderajatState();
}

class _TarungderajatState extends State<Tarungderajat> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Tarung derajat/Tarung derajat')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Tarung derajat',
        pathGambar: 'divisi/tarungderajat.png');
  }
}
//fitur div Tarungderajat

class Taekwondo extends StatefulWidget {
  const Taekwondo({super.key});

  @override
  State<Taekwondo> createState() => _TaekwondoState();
}

class _TaekwondoState extends State<Taekwondo> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/divisi/view/Taekwondo/Taekwondo')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0].toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return anggotaDivisi(
        dataAnggota: dataAnggota,
        namaDivisi: 'Taekwondo',
        pathGambar: 'divisi/taekwondo.png');
  }
}
//fitur div Taekwondo
