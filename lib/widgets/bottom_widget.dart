import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/screens/first_screen.dart';
import 'package:testapp/strings.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class NewWidget extends StatefulWidget {
  NewWidget({Key? key, required this.controller, required this.notifyParent}) : super(key: key);
  final PlatformWebViewController controller;
  final Function() notifyParent;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}


class _NewWidgetState extends State<NewWidget> {
  int investmentAmount = 1000;
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 1);

  void sellOrBuy(int inv){
    Random random = Random();
    if(balance-inv >= 0){
      if(random.nextBool() == true){
        balance = balance+(inv/100*70).toInt();
      }else{
        balance = balance-inv;
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Container(
      height: 200,
      color: Color(0xff121629),
      //Color(0xff1C1F2D),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              var currentPair = await Navigator.pushNamed(context, '/pairScreen', arguments: pair);
              setState(() {
                pair = currentPair.toString();
                widget.controller.loadHtmlString(widgetCode(pair));

              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff333749),
              ),
              width: 350,
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    formatCurrencyPair(pair),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.chevron_right_sharp,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 170,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff333749),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Timer',
                      style: TextStyle(color: Color(0xffC8C8C8), fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              final seconds = myDuration.inSeconds - 1;
                              if (seconds < 0) {
                                countdownTimer!.cancel();
                              } else {
                                myDuration = Duration(seconds: seconds);
                              }
                            });
                          },
                          child: Icon(
                            Icons.remove_circle_outline_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$minutes:$seconds',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              final seconds = myDuration.inSeconds + 1;
                              if (seconds < 0) {
                                countdownTimer!.cancel();
                              } else {
                                myDuration = Duration(seconds: seconds);
                              }
                            });
                          },
                          child: Icon(
                            Icons.add_circle_outline_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 170,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff333749),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Investment',
                      style: TextStyle(color: Color(0xffC8C8C8), fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            child: Icon(
                              Icons.remove_circle_outline_sharp,
                              color: Colors.white,
                            ),
                            onTap: () {
                              setState(() {
                                if(investmentAmount-100 <= 0){
                                  return;
                                }else{
                                  investmentAmount = investmentAmount-100;
                                }
                              });
                              print(investmentAmount);
                            }
                        ),
                        Text(
                          '${formatNumberWithCommas(investmentAmount)}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        InkWell(
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                            ),
                            onTap: () {
                              setState(() {
                                investmentAmount = investmentAmount+100;
                               });
                              print(investmentAmount);
                            }
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                    sellOrBuy(investmentAmount);
                    widget.notifyParent();
                    print(balance);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Successfully"),
                    ));
                },
                child: Container(
                  width: 170,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFE3D43),
                  ),
                  child: Center(
                    child: Text(
                      'Sell        ',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  sellOrBuy(investmentAmount);
                  widget.notifyParent();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Successfully"),
                  ));
                  },
                child: Container(
                  width: 170,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff35B972),
                  ),
                  child: Center(
                    child: Text(
                      'Buy        ',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
