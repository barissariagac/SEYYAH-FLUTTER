import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:seyyah/constants/const.dart';
import '../widgets/spacer_sizedbox.dart';

class SelectedRoute extends StatefulWidget {
  @override
  _SelectedRouteState createState() => _SelectedRouteState();
}

class _SelectedRouteState extends State<SelectedRoute> {
  @override
  Widget build(BuildContext context) {
    Map selectedItems = ModalRoute.of(context).settings.arguments;
    CollectionReference routedataRef = FirebaseFirestore.instance
        .collection("cities/${selectedItems['city']}/routes");
    var routedata = routedataRef.doc('${selectedItems['city']}_routes');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedItems['routes'],
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "assets/map/${selectedItems['routes']}_map.png"),
                ),
              ),
            ),
          ),
          SpacerSizedBox(),
          Flexible(
            child: StreamBuilder<DocumentSnapshot>(
                stream: routedata.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Birseyler yanlis gitti");
                  } else {
                    if (snapshot.hasData) {
                      Map data = snapshot.data.data();
                      List selectedRoute = data[selectedItems['routes']];
                      return ListView.builder(
                        itemCount: selectedRoute.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTapDown: (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      new SnackBar(
                                          content: new Text(
                                              ' ${selectedRoute[index]}')));
                                },
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/selectedPointPage",
                                        arguments: {
                                          'city': selectedItems['city'],
                                          'selectedPoint': selectedRoute[index]
                                        });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: FullScreenWidget(
                                            backgroundColor: backgroundColor,
                                            disposeLevel: DisposeLevel.Low,
                                            child: Center(
                                              child: Hero(
                                                tag: "smallImage",
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Image.asset(
                                                    "assets/images/${selectedItems['city']}/${selectedRoute[index]}.jpg",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SpacerSizedBox(),
                                      Flexible(
                                        child: Text(
                                          selectedRoute[index].toString(),
                                          maxLines: 3,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SpacerSizedBox(),
                            ],
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
                }),
          )
        ],
      ),
    );
  }
}
