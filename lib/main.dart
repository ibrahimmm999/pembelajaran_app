import 'package:flutter/material.dart';
import 'package:pwa_ngajar/provider/material_provider.dart';
import 'package:pwa_ngajar/provider/quiz_provider.dart';
import 'package:pwa_ngajar/provider/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pwa_ngajar/pages/detail_quiz_page.dart';
import 'package:pwa_ngajar/pages/start_quiz_page.dart';
import 'package:pwa_ngajar/pages/main_page.dart';
import 'package:pwa_ngajar/pages/role_page.dart';
import 'package:pwa_ngajar/provider/page_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://rrqdjeypajwusjewkncj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJycWRqZXlwYWp3dXNqZXdrbmNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5Njc3NTYsImV4cCI6MjA2MDU0Mzc1Nn0.FtqniXdwH7sSOiHRWTahLUGAl75eQZ4pJ5CkUPWsyvo',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => MaterialProvider()),
        ChangeNotifierProvider(create: (context) => QuizProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => RolePage(),
          '/main': (context) => MainPage(),
          '/start-quiz': (context) => StartQuizPage(),
          '/detail-quiz': (context) => DetailQuizPage(),
        },
      ),
    );
  }
}
