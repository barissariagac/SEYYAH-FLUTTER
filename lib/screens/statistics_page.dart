import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';
import 'package:seyyah/core/api_provider/api_user_model.dart';
import 'package:http/http.dart' as http;

class StatisticsPage extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  int counter;
  ApiUserModel userResult;

  final url = Uri.parse('https://reqres.in/api/users');
  Future callUser() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = apiUserModelFromJson(response.body);
        if (mounted)
          setState(() {
            counter = result.data.length;
            userResult = result;
          });
        return result;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    callUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İstatistikler"),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  height: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: primaryColor,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Ziyaretçi İstatistikleri',
                                style: TextStyle(
                                    color: backgroundColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Haftalık Grafik',
                                style: TextStyle(
                                    color: const Color(0xFFC2D1CE),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: BarChart(
                                    isPlaying ? randomData() : mainBarData(),
                                    swapAnimationDuration: animDuration,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: backgroundColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                  if (isPlaying) {
                                    refreshState();
                                  }
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "En Son Ziyaret Edenler",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Divider()
              ],
            ),
          ),
          Flexible(
            child: counter != null
                ? ListView.builder(
                    itemCount: counter,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(userResult.data[index].email),
                                  title: Text("E-mail adresi"),
                                );
                              });
                        },
                        child: ListTile(
                          leading: GestureDetector(
                            onDoubleTap: () {
                              return showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Image(
                                        image: NetworkImage(
                                            '${userResult.data[index].avatar}'),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${userResult.data[index].avatar}'),
                            ),
                          ),
                          title: Text(
                              '${userResult.data[index].firstName} ${userResult.data[index].lastName}'),
                          subtitle:
                              Text('${userResult.data[index].id} saat önce'),
                        ),
                      );
                    })
                : Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.deepOrange,
    double width = 25,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.amber] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 300,
            colors: [backgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 150, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 130, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 155, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 145, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 220, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 265, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 245, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Pazartesi';
                  break;
                case 1:
                  weekDay = 'Salı';
                  break;
                case 2:
                  weekDay = 'Çarşamba';
                  break;
                case 3:
                  weekDay = 'Perşembe';
                  break;
                case 4:
                  weekDay = 'Cuma';
                  break;
                case 5:
                  weekDay = 'Cumatesi';
                  break;
                case 6:
                  weekDay = 'Pazar';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'P';
              case 1:
                return 'S';
              case 2:
                return 'Ç';
              case 3:
                return 'P';
              case 4:
                return 'C';
              case 5:
                return 'C';
              case 6:
                return 'P';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'P';
              case 1:
                return 'S';
              case 2:
                return 'Ç';
              case 3:
                return 'P';
              case 4:
                return 'C';
              case 5:
                return 'C';
              case 6:
                return 'P';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(300).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(300).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(300).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(300).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(300).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(300).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(300).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
