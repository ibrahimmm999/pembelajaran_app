import 'package:flutter/material.dart';
import 'package:pwa_ngajar/shared/theme.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> materiItems = [
      {
        'title':
            'Kuis Pemanfaatan dan Pelestarian Potensi SDA Sebagai Bahan Baku Produksi',
        'kelas': 'Kelas VII',
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 64, right: 80, bottom: 40),
        children: [
          Text(
            "Quiz",
            style: heading1.copyWith(
              fontWeight: bold,
              color: darkColor,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Column(
            children: materiItems.map(
              (e) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/start-quiz');
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: darkColor),
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e['title']!,
                            style: paragraph.copyWith(
                                fontWeight: bold, color: darkColor),
                          ),
                          Text(
                            "Kelas VII",
                            style: small.copyWith(color: greyColor),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
