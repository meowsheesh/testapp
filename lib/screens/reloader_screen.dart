import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PreloaderScreen extends StatefulWidget {
  const PreloaderScreen({Key? key}) : super(key: key);

  @override
  State<PreloaderScreen> createState() => _PreloaderScreenState();
}

class _PreloaderScreenState extends State<PreloaderScreen> {

  double percent = 0.0;
  late Timer timer;
  late Timer permissionTimer;
  bool notif = false;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds:20),(_){
      setState(() {
        percent+=1;
        if(percent >= 100){
          timer.cancel();
          // percent=0;
        }
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/BG.png"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 50,
            animation: true,
            lineHeight: 25.0,
            animationDuration: 2000,
            percent: 1,
            center: Text(percent.toString() + "%", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),),
            barRadius: Radius.circular(12),
            progressColor: Color(0xff35B972),
            onAnimationEnd: () {
              Future<PermissionStatus> permissionStatus = NotificationPermissions.requestNotificationPermissions();
              Navigator.pushNamed(context, '/firstScreen');
              },
          ),
        ),
      ),
    );
  }
}
