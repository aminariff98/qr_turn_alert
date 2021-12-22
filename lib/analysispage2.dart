import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/LineChartSample.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisPage2 extends StatefulWidget {
  @override
  _AnalysisPage2State createState() => _AnalysisPage2State();
}

class _AnalysisPage2State extends State<AnalysisPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('July 2021'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Text("Number of Customers per day", style: TextStyle(
            fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black12,
                height: 250,
                width: 350,
                child: LineChart(sampleData1()),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text("Total Number of Customers At A Given Time", style: TextStyle(
              fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black12,
                height: 250,
                width: 350,
                child: LineChart(sampleData2()),
              ),
            ],
          ),


          SizedBox(height: 20,),
          Text("Total Number of Customers by Counter", style: TextStyle(
              fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black12,
                height: 350,
                width: 350,
                child: BarChart(BarChartData(
                    gridData: FlGridData(
                      show: true,
                    ),
                    titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 25,
                          rotateAngle: 0,

                          margin: 10,
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 0:
                                return '';
                              case 1:
                                return 'Finance';
                              case 2:
                                return 'Investment';
                              case 3:
                                return 'Loan';
                              case 4:
                                return 'Deposit';
                            }
                            return '';

                          },
                        ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        margin: 5,
                        reservedSize: 20,
                      ),

                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 4,
                        ),
                        left: BorderSide(
                          color: Colors.black,
                          width: 4,
                        ),
                        right: BorderSide(
                          color: Colors.transparent,
                        ),
                        top: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),

                    ),
                    maxY: 100,
                    minY: 0,

                  barGroups: [
                    BarChartGroupData(x: 1,barRods: [
                      BarChartRodData(y: 90, width: 50, colors: const [
                        Color(0xff27b6fc),
                      ],borderRadius: BorderRadius.circular(5)),
                    ]),
                    BarChartGroupData(x: 2,barRods: [
                      BarChartRodData(y: 60, width: 50, colors: const [
                        Color(0xff27b6fc),
                      ],borderRadius: BorderRadius.circular(5)),
                    ]),
                    BarChartGroupData(x: 3,barRods: [
                      BarChartRodData(y: 30, width: 50, colors: const [
                        Color(0xff27b6fc),
                      ],borderRadius: BorderRadius.circular(5)),
                    ]),
                    BarChartGroupData(x: 4,barRods: [
                      BarChartRodData(y: 60, width: 50, colors: const [
                        Color(0xff27b6fc),
                      ],borderRadius: BorderRadius.circular(5)),
                    ])

                  ]
                )),
              ),
            ],
          ),

          SizedBox(height: 20,),
          Text("Total Number of Customers At A Given Time", style: TextStyle(
              fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black12,
                height: 250,
                width: 350,
                child: LineChart(sampleData2()),
              ),
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          rotateAngle: 90,

          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '1';
              case 1:
                return '2';
              case 2:
                return '3';
              case 3:
                return '4';
              case 4:
                return '5';
              case 5:
                return '6';
              case 6:
                return '7';
              case 7:
                return '8';
              case 8:
                return '9';
              case 9:
                return '10';
              case 10:
                return '11';
              case 11:
                return '12';
              case 12:
                return '13';
              case 13:
                return '14';
              case 14:
                return '15';
              case 15:
                return '16';
              case 16:
                return '17';
              case 17:
                return '18';
              case 18:
                return '19';
              case 19:
                return '20';
              case 20:
                return '21';
              case 21:
                return '22';
              case 22:
                return '23';
              case 23:
                return '24';
              case 24:
                return '25';
              case 25:
                return '26';
              case 26:
                return '27';
              case 27:
                return '28';
              case 28:
                return '29';
              case 29:
                return '30';
              case 30:
                return '31';
              case 31:
                return '';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              case 6:
                return '6';
              case 7:
                return '7';
              case 8:
                return '8';
              case 9:
                return '9';
              case 10:
                return '10';
              case 11:
                return '11';
              case 12:
                return '12';
              case 13:
                return '13';
              case 14:
                return '14';
              case 15:
                return '15';
              case 16:
                return '16';
              case 17:
                return '17';
              case 18:
                return '18';
              case 19:
                return '19';
              case 20:
                return '20';
            }
            return '';
          },
          margin: 5,
          reservedSize: 20,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 4,
          ),
          left: BorderSide(
            color: Colors.black,
            width: 4,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 31,
      maxY: 20,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      // all the spots of the line chart.
      spots: [
        FlSpot(0, 16),
        FlSpot(1, 15),
        FlSpot(2, 15),
        FlSpot(3, 14),
        FlSpot(4, 11),
        FlSpot(5, 10),
        FlSpot(6, 8),
        FlSpot(7, 6),
        FlSpot(8, 4),
        FlSpot(9, 5),
        FlSpot(10, 5),
        FlSpot(11, 4),
        FlSpot(12, 6),
        FlSpot(13, 7),
        FlSpot(14, 6),
        FlSpot(15, 5),
        FlSpot(16, 7),
        FlSpot(17, 4),
        FlSpot(18, 4),
        FlSpot(19, 5),
        FlSpot(20, 3),
        FlSpot(21, 7),
        FlSpot(22, 8),
        FlSpot(23, 5),

      ],
      // curved or straight line.
      isCurved: true,
      // Color of the rod.
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 6,
      // Data of dot.
      dotData: FlDotData(
        show: false,
      ),
      // To highlight the data below the line curve.
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Color(0xffaa4cfc).withOpacity(0.3),
        ],
      ),
    );

    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Color(0xffaa4cfc).withOpacity(0.3),
        ],
      ),
    );

    return [
      lineChartBarData1
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 25,
          rotateAngle: 90,

          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0:00';
              case 1:
                return '1:00';
              case 2:
                return '2:00';
              case 3:
                return '3:00';
              case 4:
                return '4:00';
              case 5:
                return '5:00';
              case 6:
                return '6:00';
              case 7:
                return '7:00';
              case 8:
                return '8:00';
              case 9:
                return '9:00';
              case 10:
                return '10:00';
              case 11:
                return '11:00';
              case 12:
                return '12:00';
              case 13:
                return '13:00';
              case 14:
                return '14:00';
              case 15:
                return '15:00';
              case 16:
                return '16:00';
              case 17:
                return '17:00';
              case 18:
                return '18:00';
              case 19:
                return '19:00';
              case 20:
                return '20:00';
              case 21:
                return '21:00';
              case 22:
                return '22:00';
              case 23:
                return '23:00';
              case 24:
                return '24:00';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              case 6:
                return '6';
              case 7:
                return '7';
              case 8:
                return '8';
              case 9:
                return '9';
              case 10:
                return '10';
              case 11:
                return '11';
              case 12:
                return '12';
              case 13:
                return '13';
              case 14:
                return '14';
              case 15:
                return '15';
              case 16:
                return '16';
              case 17:
                return '17';
              case 18:
                return '18';
              case 19:
                return '19';
              case 20:
                return '20';
              case 25:
                return '25';
              case 30:
                return '30';
              case 35:
                return '35';
              case 40:
                return '40';
              case 45:
                return '45';
              case 50:
                return '50';
              case 55:
                return '55';
              case 60:
                return '60';
            }
            return '';
          },
          margin: 5,
          reservedSize: 20,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 4,
          ),
          left: BorderSide(
            color: Colors.black,
            width: 4,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 25,
      maxY: 60,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      // all the spots of the line chart.
      spots: [
        FlSpot(0, 0),
        FlSpot(1, 0),
        FlSpot(2, 0),
        FlSpot(3, 0),
        FlSpot(4, 0),
        FlSpot(5, 0),
        FlSpot(6, 0),
        FlSpot(7, 0),
        FlSpot(8, 15),
        FlSpot(9, 18),
        FlSpot(10, 24),
        FlSpot(11, 34),
        FlSpot(12, 44),
        FlSpot(13, 36),
        FlSpot(14, 33),
        FlSpot(15, 25),
        FlSpot(16, 22),
        FlSpot(17, 23),
        FlSpot(18, 0),
        FlSpot(19, 0),
        FlSpot(20, 0),
        FlSpot(21, 0),
        FlSpot(22, 0),
        FlSpot(23, 0),
        FlSpot(24, 0),
      ],
      // curved or straight line.
      isCurved: true,
      // Color of the rod.
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 6,
      // Data of dot.
      dotData: FlDotData(
        show: false,
      ),
      // To highlight the data below the line curve.
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Color(0xffaa4cfc).withOpacity(0.3),
        ],
      ),
    );

    return [
      lineChartBarData1
    ];
  }

  BarChartData _mainBarData() {
    return BarChartData(
      maxY: 20,
      titlesData: _buildAxes(),
      borderData: FlBorderData(
        show: false,
      ),
    );
  }

  FlTitlesData _buildAxes() {
    return FlTitlesData(
      show: true,
      // Build X axis.
      bottomTitles: SideTitles(
        showTitles: true,
        margin: 20,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return 'Mn';
            case 1:
              return 'Te';
            case 2:
              return 'Wd';
            case 3:
              return 'Tu';
            case 4:
              return 'Fr';
            case 5:
              return 'St';
            case 6:
              return 'Sn';
            default:
              return '';
          }
        },
      ),
      // Build Y axis.
      leftTitles: SideTitles(
        showTitles: true,
        margin: 32,
        reservedSize: 14,
        getTitles: (value) {
          if (value == 0) {
            return '1K';
          } else if (value == 10) {
            return '5K';
          } else if (value == 19) {
            return '10K';
          } else {
            return '';
          }
        },
      ),
    );
  }
}