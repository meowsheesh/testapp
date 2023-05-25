import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testapp/screens/first_screen.dart';
import 'package:testapp/screens/reloader_screen.dart';
import 'screens/pair_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PreloaderScreen(),
        '/firstScreen': (context) => MyHomePage(),
        '/pairScreen': (context) => PairScreen(),
      }
    );
  }
}


