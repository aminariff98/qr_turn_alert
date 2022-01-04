import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:qr_turn_alert/main.dart';

class Chart extends StatefulWidget {
  final data;

  const Chart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final List<int> showIndexes = const [0, 1, 2, 3, 4, 5, 6];

  List date = [];
  List dateDisplay = [];
  List values = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  var currentDate;
  var now = DateTime.now();
  List<FlSpot> amount = [];
  final List<FlSpot> allSpots = [
    FlSpot(0, 4),
    FlSpot(1, 2),
    FlSpot(2, 9.5),
    FlSpot(3, 3),
    FlSpot(4, 3.5),
    FlSpot(5, 5),
    FlSpot(6, 8),
  ];

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat('yyyy-MM-dd').format(now);
    for (int i = 6; i >= 0; i--) {
      date.add(DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: i))).toString());
    }
    widget.data.forEach((item) {
      for (int i = 0; i < 7; i++) {
        if (item['date'] == date[i]) {
          values[i] += 1.0;
        }
      }
    });

    double count = 0;
    for (int i = 0; i < 7; i++) {
      amount.add(FlSpot(count, values[i]));
      count++;
    }
    _setData();
  }

  _setData() {
    for (int i = 6; i >= 0; i--) {
      dateDisplay.add(DateFormat('yyyy-MMM-dd').format(now.subtract(Duration(days: i))).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    final lineBarsData = [
      LineChartBarData(
          showingIndicators: showIndexes,
          spots: amount,
          isCurved: true,
          barWidth: 3,
          shadow: const Shadow(
            blurRadius: 8,
            color: Colors.black,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              const Color(0xff12c2e9).withOpacity(0.4),
              const Color(0xffc471ed).withOpacity(0.4),
              const Color(0xfff64f59).withOpacity(0.4),
            ],
          ),
          dotData: FlDotData(show: false),
          colors: [
            const Color(0xff12c2e9),
            const Color(0xffc471ed),
            const Color(0xfff64f59),
          ],
          colorStops: [
            0.1,
            0.4,
            0.9
          ]),
    ];

    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return Container(
      constraints: BoxConstraints(maxHeight: userScreenHeight * 0.15, maxWidth: userScreenWidth * 0.85),
      child: LineChart(
        LineChartData(
          showingTooltipIndicators: showIndexes.map((index) {
            return ShowingTooltipIndicators(index, [
              LineBarSpot(tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar), tooltipsOnBar.spots[index]),
            ]);
          }).toList(),
          lineTouchData: LineTouchData(
            enabled: false,
            getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  FlLine(
                    color: Colors.grey[350]!.withOpacity(0.5),
                  ),
                  FlDotData(
                    show: false,
                    getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                      radius: 8,
                      color: lerpGradient(barData.colors, barData.colorStops, percent / 100),
                      strokeWidth: 2,
                      strokeColor: Colors.black,
                    ),
                  ),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipRoundedRadius: 8,
              tooltipMargin: 3,
              getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                return lineBarsSpot.map((lineBarSpot) {
                  return LineTooltipItem(
                    lineBarSpot.y.toString().substring(0, lineBarSpot.y.toString().indexOf('.')),
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0 + userTextSize),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: lineBarsData,
          minY: 0,
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (val) {
                  switch (val.toInt()) {
                    case 0:
                      return dateDisplay[0].substring(5, dateDisplay[0].length);
                    case 1:
                      return dateDisplay[1].substring(5, dateDisplay[1].length);
                    case 2:
                      return dateDisplay[2].substring(5, dateDisplay[2].length);
                    case 3:
                      return dateDisplay[3].substring(5, dateDisplay[3].length);
                    case 4:
                      return dateDisplay[4].substring(5, dateDisplay[4].length);
                    case 5:
                      return dateDisplay[5].substring(5, dateDisplay[5].length);
                    case 6:
                      return dateDisplay[6].substring(5, dateDisplay[6].length);
                  }
                  return '';
                },
                getTextStyles: (value) => TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white38,
                      fontFamily: 'Digital',
                      fontSize: 12.0 + userTextSize,
                    )),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: false,
          ),
        ),
      ),
    );
  }
}

Color? lerpGradient(List<Color> colors, List<double>? stops, double t) {
  if (stops == null || stops.length != colors.length) {
    stops = [];

    colors.asMap().forEach((index, color) {
      final percent = 1.0 / colors.length;
      stops!.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT);
    }
  }
  return colors.last;
}
