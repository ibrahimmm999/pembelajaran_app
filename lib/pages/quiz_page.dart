// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:pwa_ngajar/provider/user_provider.dart';
// import 'package:pwa_ngajar/shared/theme.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class QuizPage extends StatefulWidget {
//   const QuizPage({super.key});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   late Future<List<Map<String, dynamic>>> _quizFuture;
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController numberOfQuestionController =
//       TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _refreshQuiz();
//   }

//   Future<void> _refreshQuiz() async {
//     setState(() {
//       _quizFuture = Supabase.instance.client
//           .from('quiz')
//           .select()
//           .order('created_at', ascending: false);
//     });
//   }

//   Future<void> _addQuiz() async {
//     final title = titleController.text.trim();
//     final numberOfQuestions = numberOfQuestionController.text.trim();

//     // Validate inputs
//     if (title.isEmpty || numberOfQuestions.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Input harus diisi')),
//       );
//       return;
//     }

//     try {
//       // Insert into Supabase
//       await Supabase.instance.client.from('quiz').insert({
//         'title': title,
//         'number_of_questions': numberOfQuestions,
//       });

//       // Clear text fields
//       titleController.clear();
//       numberOfQuestionController.clear();

//       // Refresh the materials list
//       await _refreshQuiz();

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Quiz berhasil ditambahkan')),
//       );
//     } catch (e) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Gagal menambahkan quiz: ${e.toString()}')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: FutureBuilder(
//         future: _quizFuture,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//                 child: CircularProgressIndicator(
//               color: primaryBlue,
//             ));
//           }
//           final quiz = snapshot.data!;

//           return ListView(
//             padding: EdgeInsets.only(left: 64, right: 80, bottom: 40),
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: userProvider.isGuru
//                     ? MainAxisAlignment.spaceBetween
//                     : MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Quiz",
//                     style: heading1.copyWith(
//                       fontWeight: bold,
//                       color: darkColor,
//                     ),
//                   ),
//                   Visibility(
//                     visible: userProvider.isGuru,
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 12, horizontal: 20),
//                             backgroundColor: primaryBlue,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16))),
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 backgroundColor: whiteColor,
//                                 title: Text(
//                                   "Tambah Quiz",
//                                   style: heading3.copyWith(
//                                       color: darkColor, fontWeight: bold),
//                                 ),
//                                 content: Container(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 20, horizontal: 20),
//                                   width: MediaQuery.sizeOf(context).width / 2,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         "Judul",
//                                         style:
//                                             heading4.copyWith(color: darkColor),
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 12),
//                                         decoration: BoxDecoration(
//                                             color: whiteColor,
//                                             border:
//                                                 Border.all(color: darkColor),
//                                             borderRadius:
//                                                 BorderRadius.circular(16)),
//                                         child: TextFormField(
//                                           controller: titleController,
//                                           decoration: InputDecoration(
//                                               border: InputBorder.none),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         "Jumlah Soal",
//                                         style:
//                                             heading4.copyWith(color: darkColor),
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 12),
//                                         decoration: BoxDecoration(
//                                             color: whiteColor,
//                                             border:
//                                                 Border.all(color: darkColor),
//                                             borderRadius:
//                                                 BorderRadius.circular(16)),
//                                         child: TextFormField(
//                                           controller:
//                                               numberOfQuestionController,
//                                           decoration: InputDecoration(
//                                               border: InputBorder.none),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 16,
//                                                       horizontal: 20),
//                                                   backgroundColor:
//                                                       Color(0xffEE6055)),
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Text(
//                                                 "Batal",
//                                                 style: paragraph.copyWith(
//                                                     color: whiteColor,
//                                                     fontWeight: bold),
//                                               )),
//                                           SizedBox(
//                                             width: 12,
//                                           ),
//                                           ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 16,
//                                                       horizontal: 20),
//                                                   backgroundColor: primaryBlue),
//                                               onPressed: () async {
//                                                 await _addQuiz();
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Text(
//                                                 "Tambah",
//                                                 style: paragraph.copyWith(
//                                                     color: whiteColor,
//                                                     fontWeight: bold),
//                                               )),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         child: Text(
//                           "Tambah +",
//                           style: heading3.copyWith(
//                               color: whiteColor, fontWeight: bold),
//                         )),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 32,
//               ),
//               Column(
//                 children: quiz.map(
//                   (e) {
//                     return Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       child: InkWell(
//                         onTap: () {
//                           if (userProvider.isGuru) {
//                             Navigator.pushNamed(context, '/admin-quiz',
//                                 arguments: {
//                                   "id": e['id'],
//                                   "numberOfQuestions": e['number_of_questions'],
//                                 });
//                           } else {
//                             Navigator.pushNamed(context, '/start-quiz',
//                                 arguments: {
//                                   "id": e['id'],
//                                   "numberOfQuestions": e['number_of_questions'],
//                                 });
//                           }
//                         },
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: darkColor),
//                               borderRadius: BorderRadius.circular(20)),
//                           padding: EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 e['title']!,
//                                 style: paragraph.copyWith(
//                                     fontWeight: bold, color: darkColor),
//                               ),
//                               Text(
//                                 "Jumlah Soal : ${e['number_of_questions']}",
//                                 style: small.copyWith(color: greyColor),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ).toList(),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pwa_ngajar/shared/theme.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/work-in-progress.png",
              height: 200,
            ),
            Text(
              "Under Construction",
              style: heading1.copyWith(color: darkColor, fontWeight: bold),
            )
          ],
        ),
      ),
    );
  }
}
