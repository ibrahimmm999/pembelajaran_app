import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwa_ngajar/pages/materi_page.dart';
import 'package:pwa_ngajar/pages/quiz_page.dart';
import 'package:pwa_ngajar/pages/task_page.dart';
import 'package:pwa_ngajar/pages/video_page.dart';
import 'package:pwa_ngajar/provider/page_provider.dart';
import 'package:pwa_ngajar/provider/user_provider.dart';
import 'package:pwa_ngajar/shared/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Widget buildContent() {
      int newPage = pageProvider.page;
      if (!userProvider.isGuru) {
        switch (newPage) {
          case 0:
            {
              return VideoPage();
            }
          case 1:
            {
              return const TaskPage();
            }
          case 2:
            {
              return QuizPage();
            }

          default:
            {
              return VideoPage();
            }
        }
      } else {
        switch (newPage) {
          case 0:
            {
              return MateriPage();
            }
          case 1:
            {
              return const VideoPage();
            }
          case 2:
            {
              return TaskPage();
            }
          case 3:
            {
              return QuizPage();
            }

          default:
            {
              return MateriPage();
            }
        }
      }
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width / 8, top: 60),
            child: buildContent(),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 40),
            height: double.infinity,
            width: MediaQuery.sizeOf(context).width / 8,
            decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Visibility(
                    visible: userProvider.isGuru,
                    child: NavigationItem(label: "Materi", index: 0)),
                SizedBox(
                  height: 40,
                ),
                NavigationItem(
                    label: "Video", index: userProvider.isGuru ? 1 : 0),
                SizedBox(
                  height: 40,
                ),
                NavigationItem(
                    label: "Tugas", index: userProvider.isGuru ? 2 : 1),
                SizedBox(
                  height: 40,
                ),
                NavigationItem(
                    label: "Quiz", index: userProvider.isGuru ? 3 : 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final String label;
  final int index;
  const NavigationItem({super.key, required this.label, required this.index});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    return InkWell(
      onTap: () {
        pageProvider.setPage(index);
      },
      child: Text(
        label,
        style: index == pageProvider.page
            ? heading3.copyWith(color: whiteColor, fontWeight: bold)
            : paragraph.copyWith(color: whiteColor),
      ),
    );
  }
}
