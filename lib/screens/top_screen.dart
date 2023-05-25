import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/strings.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  final Widget svg =
      SvgPicture.asset('assets/003-austria.svg', semanticsLabel: 'Acme Logo');

  List<DataRow> _createRows() {
    bool isEven = false;

    return traders.map((trade) {
      isEven = !isEven;
      final backgroundColor = isEven ? Color(0xff1C1F2D) : Color(0xff2E303E);

      return DataRow(
        color: MaterialStateColor.resolveWith((states) => backgroundColor!),
        cells: [
          DataCell(
            Text(
              trade['id'].toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              trade['country'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              trade['name'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              trade['depo'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              trade['prof'],
              style: TextStyle(color: Color(0xff35B972)),
            ),
          ),
        ],
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: const Color(0xff2E303E),
          ),
          columns: const [
            DataColumn(label: Text('№', style: TextStyle(color: Color(0xffC1C2C8)),)),
            DataColumn(label: Text('Country', style: TextStyle(color: Color(0xffC1C2C8)),)),
            DataColumn(label: Text('Name', style: TextStyle(color: Color(0xffC1C2C8)),)),
            DataColumn(label: Text('Deposit', style: TextStyle(color: Color(0xffC1C2C8)),)),
            DataColumn(label: Text('Profit', style: TextStyle(color: Color(0xffC1C2C8)),)),
          ],
          rows: _createRows(),
        ),
      ),
    );
  }
}


//List<DataRow>.generate(
//             10,
//             (index) => DataRow(
//               color: MaterialStateColor.resolveWith((states) {
//                 // Set alternating zebra colors
//                 return index % 2 == 0 ? Colors.white : Colors.grey[200]!;
//               }),
//               cells: [
//                 DataCell(Text((index + 1).toString())),
//                 DataCell(svg),
//                 DataCell(Text('Name ${index + 1}')),
//                 DataCell(Text('Deposit ${index + 1}')),
//                 DataCell(Text('Profit ${index + 1}')),
//               ],
//             ),
//           ),