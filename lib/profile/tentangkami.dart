import 'package:flutter/material.dart';

class tentangKami extends StatelessWidget {
  const tentangKami({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: ClipOval(
                  child: Image.asset('img/kosim.jpg'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Nama',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          ':',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '  Moh Kosim',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 10),
                      child: Row(
                        children: [
                          Text(
                            'Nim',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            ':',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '  2132123',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 10),
                      child: Row(
                        children: [
                          Text( 
                            'Prodi',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            ':',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '  TRPL',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
