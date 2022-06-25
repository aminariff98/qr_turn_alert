// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_turn_alert/constants.dart';
// import 'package:fl_chart/fl_chart.dart';

// class AnalysisPage extends StatefulWidget {
//   @override
//   _AnalysisPageState createState() => _AnalysisPageState();
// }

// class _AnalysisPageState extends State<AnalysisPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 320,
//       margin: EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(18)),
//         gradient: LinearGradient(
//           colors: const [
//             Colors.white,
//             Color(0xff46426c),
//           ],
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           const SizedBox(
//             height: 25,
//           ),
//           const Text(
//             'Daily Customers',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(
//             height: 4,
//           ),

//           const SizedBox(
//             height: 25,
//           ),
//           /*Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(right: 16.0, left: 6.0),
//               child: LineChart(sampleData1()),
//             ),
//           ),*/
//           Container(
//             height: 450,
//             width: 250,
//             child: LineChart(sampleData1()),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     );
//   }

//   LineChartData sampleData1() {
//     return LineChartData(
//       lineTouchData: LineTouchData(
//         touchTooltipData: LineTouchTooltipData(
//           tooltipBgColor: Colors.white,
//         ),
//         touchCallback: (LineTouchResponse touchResponse) {},
//         handleBuiltInTouches: true,
//       ),
//       gridData: FlGridData(
//         show: false,
//       ),
//       titlesData: FlTitlesData(
//         bottomTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 22,

//           margin: 10,
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 2:
//                 return 'SEPT';
//               case 7:
//                 return 'OCT';
//               case 12:
//                 return 'DEC';
//             }
//             return '';
//           },
//         ),
//         leftTitles: SideTitles(
//           showTitles: true,
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 1:
//                 return '1m';
//               case 2:
//                 return '2m';
//               case 3:
//                 return '3m';
//               case 4:
//                 return '5m';
//             }
//             return '';
//           },
//           margin: 8,
//           reservedSize: 30,
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: const Border(
//           bottom: BorderSide(
//             color: Colors.red,
//             width: 4,
//           ),
//           left: BorderSide(
//             color: Colors.transparent,
//           ),
//           right: BorderSide(
//             color: Colors.transparent,
//           ),
//           top: BorderSide(
//             color: Colors.transparent,
//           ),
//         ),
//       ),
//       minX: 0,
//       maxX: 14,
//       maxY: 4,
//       minY: 0,
//       lineBarsData: linesBarData1(),
//     );
//   }

//   List<LineChartBarData> linesBarData1() {
//     final LineChartBarData lineChartBarData1 = LineChartBarData(
//       // all the spots of the line chart.
//       spots: [
//         FlSpot(1, 2.8),
//         FlSpot(3, 1.9),
//         FlSpot(6, 3),
//         FlSpot(10, 1.3),
//         FlSpot(13, 2.5),
//       ],
//       // curved or straight line.
//       isCurved: false,
//       // Color of the rod.
//       colors: const [
//         Color(0xff27b6fc),
//       ],
//       barWidth: 8,
//       // Data of dot.
//       dotData: FlDotData(
//         show: false,
//       ),
//       // To highlight the data below the line curve.
//       belowBarData: BarAreaData(
//         show: false,
//       ),
//     );

//     final LineChartBarData lineChartBarData2 = LineChartBarData(
//       spots: [
//         FlSpot(1, 1),
//         FlSpot(3, 1.5),
//         FlSpot(5, 1.4),
//         FlSpot(7, 3.4),
//         FlSpot(10, 2),
//         FlSpot(12, 2.2),
//         FlSpot(13, 1.8),
//       ],
//       isCurved: true,
//       colors: [
//         const Color(0xff4af699),
//       ],
//       barWidth: 8,
//       dotData: FlDotData(
//         show: false,
//       ),
//       belowBarData: BarAreaData(
//         show: false,
//       ),
//     );

//     final LineChartBarData lineChartBarData3 = LineChartBarData(
//       spots: [
//         FlSpot(1, 1),
//         FlSpot(3, 2.8),
//         FlSpot(7, 1.2),
//         FlSpot(10, 2.8),
//         FlSpot(12, 2.6),
//         FlSpot(13, 3.9),
//       ],
//       isCurved: true,
//       colors: [
//         const Color(0xffaa4cfc),
//       ],
//       barWidth: 8,
//       dotData: FlDotData(
//         show: false,
//       ),
//       belowBarData: BarAreaData(
//         show: true,
//         colors: [
//           Color(0xffaa4cfc).withOpacity(0.3),
//         ],
//       ),
//     );

//     return [
//       lineChartBarData1,
//       lineChartBarData2,
//       lineChartBarData3,
//     ];
//   }
// }