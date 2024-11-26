import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 200, // Grafik yüksekliği
        decoration: BoxDecoration(
          color: Colors.teal.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false), // Grid çizgilerini gizler
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.teal,
                width: 1,
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // getTitlesTextStyle: (context, value) => TextStyle(
                  //   color: Colors.teal,
                  //   fontSize: 12,
                  // ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // getTitlesTextStyle: (context, value) => TextStyle(
                  //   color: Colors.teal,
                  //   fontSize: 12,
                  // ),
                  // getTitles: (value) {
                  //   switch (value.toInt()) {
                  //     case 0:
                  //       return 'Mon';
                  //     case 1:
                  //       return 'Tue';
                  //     case 2:
                  //       return 'Wed';
                  //     case 3:
                  //       return 'Thu';
                  //     case 4:
                  //       return 'Fri';
                  //     case 5:
                  //       return 'Sat';
                  //     case 6:
                  //       return 'Sun';
                  //   }
                  //   return '';
                  // },
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 3), // X: 0, Y: 3
                  FlSpot(1, 1),
                  FlSpot(2, 4),
                  FlSpot(3, 1.5),
                  FlSpot(4, 3.2),
                  FlSpot(5, 2),
                  FlSpot(6, 3.8),
                ],
                isCurved: true,
                // colors: [Colors.teal],
                barWidth: 3,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  // colors: [Colors.teal.withOpacity(0.2)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
