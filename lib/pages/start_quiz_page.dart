import 'package:flutter/material.dart';
import 'package:pwa_ngajar/shared/theme.dart';

class StartQuizPage extends StatelessWidget {
  const StartQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: darkColor,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/quizpage.png',
                height: 420,
              ),
            ),
            Column(
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
                SizedBox(height: 20),
                Text(
                  "Kuis Sumber Daya Alam Hayati",
                  style: poppins.copyWith(
                      fontSize: 48, color: whiteColor, fontWeight: bold),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Siapa Kamu?",
                  style: poppins.copyWith(
                      fontSize: 32, color: whiteColor, fontWeight: bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width / 3,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: primaryBlue,
                    style:
                        heading2.copyWith(color: darkColor, fontWeight: medium),
                    decoration: InputDecoration(
                        hintText: "Masukkan Namamu...",
                        hintStyle: heading2.copyWith(color: darkColor),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/detail-quiz',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 28),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "Mulai Kuis",
                      style: paragraph.copyWith(
                          color: whiteColor, fontWeight: bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
