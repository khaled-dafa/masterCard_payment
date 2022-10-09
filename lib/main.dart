import 'package:flutter/material.dart';
import 'package:payment/HomeScreen.dart';
import 'package:payment/core/injection/injection_session.dart' as di;
import 'package:payment/views/screens/session_screen.dart';

import 'flutter_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SessionScreen(),
    );
  }
}
