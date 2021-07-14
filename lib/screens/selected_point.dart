import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:seyyah/constants/const.dart';

class SelectedPoint extends StatefulWidget {
  @override
  _SelectedPointState createState() => _SelectedPointState();
}

class _SelectedPointState extends State<SelectedPoint> {
  @override
  Widget build(BuildContext context) {
    Map selectedItems = ModalRoute.of(context).settings.arguments;
    CollectionReference citydataRef =
        FirebaseFirestore.instance.collection("cities");
    var citydata = citydataRef.doc("${selectedItems['city']}");
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/statisticsPage",
              );
            },
            icon: Icon(FontAwesomeIcons.solidChartBar),
            tooltip: "İstatistikler",
          )
        ],
        title: Text(
          selectedItems['selectedPoint'],
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: citydata.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Birseyler Yanlis Gitti");
            } else {
              if (snapshot.hasData) {
                Map data = snapshot.data.data();
                return Column(
                  children: [
                    Flexible(
                      child: CarouselSlider(
                        items: [
                          Container(
                            margin: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FullScreenWidget(
                              backgroundColor: backgroundColor,
                              child: Center(
                                child: Hero(
                                  tag: "smallImage",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      "assets/images/${selectedItems['city']}/${selectedItems['selectedPoint']}.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FullScreenWidget(
                              backgroundColor: Colors.white38,
                              child: Center(
                                child: Hero(
                                  tag: "smallImage",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      "assets/map/${selectedItems['selectedPoint']}_map.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                        options: CarouselOptions(
                          autoPlay: true,
                          pauseAutoPlayOnTouch: true,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              data[selectedItems['selectedPoint']],
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          }),
    );
  }
}
