import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class AppLineChart extends StatefulWidget {
  final List<dynamic> dataList;
  final String? direction;
  final double? maxY;

  const AppLineChart({Key? key, required this.dataList, this.direction, this.maxY}) : super(key: key);

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
            Radius.circular(18),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF000000),
      fontWeight: FontWeight.w500,
      fontFamily: 'SVN-Gilroy',
      fontSize: 16,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Pazartesi', style: style);
        break;
      case 6:
        text = const Text('Salı', style: style);
        break;
      case 12:
        text = const Text('Çarşamba', style: style);
        break;
      case 18:
        text = const Text('Perşembe', style: style);
        break;
      case 23:
        text = const Text('Cuma', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
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
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
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
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: widget.maxY == null ? 42 : widget.maxY!,
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
                    radius: 4, color: gradientColors[0], strokeWidth: 2, strokeColor: gradientColors[0]);
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
              colors: gradientColors.map((color) => color.withOpacity(0.4)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 2,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: widget.maxY == null ? 42 : widget.maxY!,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 10),
            FlSpot(1, 10),
            FlSpot(2, 10),
            FlSpot(3, 10),
            FlSpot(4, 10),
            FlSpot(5, 10),
            FlSpot(6, 10),
            FlSpot(7, 10),
            FlSpot(8, 10),
            FlSpot(9, 10),
            FlSpot(10, 10),
            FlSpot(11, 10),
            FlSpot(12, 10),
            FlSpot(13, 10),
            FlSpot(14, 10),
            FlSpot(15, 10),
            FlSpot(16, 10),
            FlSpot(17, 10),
            FlSpot(18, 10),
            FlSpot(19, 10),
            FlSpot(20, 10),
            FlSpot(21, 10),
            FlSpot(22, 10),
            FlSpot(23, 10),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
            ],
          ),
          barWidth: 1.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}