import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppLineChart extends StatefulWidget {
  final List<dynamic> dataList;
  final String? direction;
  final double? maxY;

  const AppLineChart(
      {Key? key, required this.dataList, this.direction, this.maxY})
      : super(key: key);

  @override
  State<AppLineChart> createState() => _AppLineChartState();
}

class _AppLineChartState extends State<AppLineChart> {
  List<Color> gradientColors = [
    const Color(0xFFBBDEFB),
    const Color(0xFF333333),
  ];

  List<FlSpot> flSpots = [];
  bool isAvg = true;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.dataList.length; i++) {
      flSpots.add(
        FlSpot(i.toDouble(), widget.dataList[i]),
      );
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isAvg = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          color: Color(0xFFBBDEFB),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 48,
            left: 48,
            top: 24,
            bottom: 24,
          ),
          child: LineChart(isAvg ? avgData() : mainData()),
          // child: LineChart(avgData()),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 2,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 5,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: flSpots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 1.5,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              if (index == DateTime.now().hour) {
                return FlDotCirclePainter(
                    radius: 4,
                    color: gradientColors[0],
                    strokeWidth: 2,
                    strokeColor: gradientColors[0]);
              } else {
                return FlDotCirclePainter(
                  radius: 0,
                  color: gradientColors[0],
                  strokeWidth: 2,
                  strokeColor: Colors.transparent,
                );
              }
            },
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.4))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 1.5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}
