import 'package:flutter/material.dart';
import 'package:testapp/enums.dart';
import 'package:testapp/strings.dart';

class PairScreen extends StatefulWidget {
  const PairScreen({Key? key}) : super(key: key);

  @override
  State<PairScreen> createState() => _PairScreenState();
}

class _PairScreenState extends State<PairScreen> {

  @override
  Widget build(BuildContext context) {
    final String currentPair = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text('Currency pair',style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
        ),
        elevation: 0,
        backgroundColor: Color(0xff121629),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xff121629),
      body: Center(
        child: GridView.count(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: (152 / 54),
          padding: EdgeInsets.only(left: 40, right: 40),
          children: [
            for (var pair in ForexPair.values)
              InkWell(
                onTap: () => Navigator.pop(context, pair.name),
                child: pairWidget(pair.name, currentPair),)
          ],
        ),
      ),
    );
  }
}

Widget pairWidget(String label, String currentPair){
  return Container(
    width: 170,
    height: 54,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: currentPair==label
        ? Color(0xff35B972) : Color(0xff333749),
    ),
    child: Center(
      child: Text(
        formatCurrencyPair(label),
        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
