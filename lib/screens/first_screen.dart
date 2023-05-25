import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/screens/top_screen.dart';
import 'package:testapp/screens/trade_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late String pair;
late int balance;
late DateTime timer;

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TradeScreen(),
    TopScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121629),
      appBar: AppBar(
        backgroundColor: Color(0xff121629),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            _currentIndex == 0 ? 'Trade' : 'TOP 10 Traders',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Color(0xff35B972),
          unselectedItemColor: Color(0xff787D8F),
          backgroundColor: Color(0xff2E3241),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph_sharp), label: 'Trade'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: 'Top'),
          ],
        ),
      ),
      body: _screens[_currentIndex],
    );
  }
}
