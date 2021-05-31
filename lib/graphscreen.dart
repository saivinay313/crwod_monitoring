import 'package:crowd_monitoring/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

var finalcount;
double data;
var format = DateFormat.j();
final time = format.format(DateTime.now()).toString();

class Graph extends StatefulWidget {
  final count;
  Graph(this.count) {
    finalcount = count;
    data = finalcount.toDouble();
  }
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final List<int> indexes = [1, 3, 5, 6];
  final List<FlSpot> allspots = [
    FlSpot(0, 1),
    FlSpot(1, 2),
    FlSpot(2, 1.5),
    FlSpot(3, 3),
    FlSpot(4, 3.5),
    FlSpot(5, 5),
    FlSpot(6, data),
  ];
  @override
  Widget build(BuildContext context) {
    final lineBarsdata = [
      LineChartBarData(
          showingIndicators: indexes,
          spots: allspots,
          isCurved: true,
          barWidth: 4,
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
    final tooltipsonBar = lineBarsdata[0];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false);
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text(
                              'KFC',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Stats',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.deepOrangeAccent,
                            Colors.orange[200]
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    left: 15,
                    right: 15,
                    child: Container(
                      child: LineChart(LineChartData(
                          backgroundColor: Colors.black26,
                          showingTooltipIndicators: indexes.map((e) {
                            return ShowingTooltipIndicators([
                              LineBarSpot(
                                  tooltipsonBar,
                                  lineBarsdata.indexOf(tooltipsonBar),
                                  tooltipsonBar.spots[e]),
                            ]);
                          }).toList(),
                          lineTouchData: LineTouchData(
                            enabled: false,
                            getTouchedSpotIndicator:
                                (LineChartBarData barData, List<int> indexes) {
                              return indexes.map((e) {
                                return TouchedSpotIndicatorData(
                                    FlLine(
                                      color: Colors.transparent,
                                    ),
                                    FlDotData(
                                        show: true,
                                        getDotPainter: (spot, percent, barData,
                                                e) =>
                                            FlDotCirclePainter(
                                                radius: 5,
                                                strokeWidth: 0.5,
                                                strokeColor: Colors.black)));
                              }).toList();
                            },
                            touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.blueAccent,
                              tooltipRoundedRadius: 8,
                              getTooltipItems:
                                  (List<LineBarSpot> lineBarsSpot) {
                                return lineBarsSpot.map((lineBarSpot) {
                                  return LineTooltipItem(
                                    lineBarSpot.y.toString(),
                                    const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                          lineBarsData: lineBarsdata,
                          minY: 0,
                          minX: 0,
                          titlesData: FlTitlesData(
                              leftTitles: SideTitles(
                                showTitles: false,
                              ),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTitles: (val) {
                                  switch (val.toInt()) {
                                    case 0:
                                      return '';
                                    case 1:
                                      return '10 PM';
                                    case 2:
                                      return '12 PM';
                                    case 3:
                                      return '2 PM';
                                    case 4:
                                      return '3 PM';
                                    case 5:
                                      return time;
                                  }
                                  return '';
                                },
                                getTextStyles: (value) => const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                    fontFamily: 'Digital',
                                    fontSize: 12),
                              )),
                          axisTitleData: FlAxisTitleData(
                            rightTitle:
                                AxisTitle(showTitle: true, titleText: "Count"),
                            leftTitle:
                                AxisTitle(showTitle: true, titleText: "Count"),
                            topTitle:
                                AxisTitle(showTitle: true, titleText: 'Time'),
                          ),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false))),
                      height: 300,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Average',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text("Customers",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "80.8",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 35),
                        )
                      ],
                    ),
                    alignment: Alignment.topLeft,
                    height: 180,
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.deepOrangeAccent,
                              Colors.orange[200]
                            ])),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Customers',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        Text("Today",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54)),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            finalcount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 40),
                          ),
                        )
                      ],
                    ),
                    alignment: Alignment.topLeft,
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.deepOrangeAccent,
                              Colors.orange[200]
                            ])),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
