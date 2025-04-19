import 'package:flutter/material.dart';
import 'package:pwa_ngajar/shared/theme.dart';

class DetailQuizPage extends StatelessWidget {
  const DetailQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    List answer = ["Pohon", "Batu", "Air", "Api"];
    return Scaffold(
      backgroundColor: darkColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/main',
                        (route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                      size: 40,
                    ))
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1. Apa bahan baku utama pembuatan kertas?",
                    style:
                        heading1.copyWith(fontWeight: bold, color: whiteColor),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    children: answer.map(
                      (e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.sizeOf(context).width / 1.3,
                              decoration: BoxDecoration(
                                color: e == answer[0]
                                    ? Color(0xffFFADAD)
                                    : e == answer[1]
                                        ? Color(0xffFFD6A5)
                                        : e == answer[2]
                                            ? Color(0xffCAFFBF)
                                            : Color(0xff9BF6FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              child: Center(
                                child: Text(
                                  e,
                                  overflow: TextOverflow.visible,
                                  style: heading2.copyWith(
                                      color: darkColor, fontWeight: bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
