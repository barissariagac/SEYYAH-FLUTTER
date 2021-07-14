import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';
import '../widgets/spacer_sizedbox.dart';

class SelectedCity extends StatefulWidget {
  @override
  _SelectedCityState createState() => _SelectedCityState();
}

class _SelectedCityState extends State<SelectedCity> {
  @override
  Widget build(BuildContext context) {
    String city = ModalRoute.of(context).settings.arguments;
    CollectionReference citydataRef =
        FirebaseFirestore.instance.collection("cities");
    var citydata = citydataRef.doc("$city");
    CollectionReference routedataRef =
        FirebaseFirestore.instance.collection("cities/$city/routes");
    var routedata = routedataRef.doc('${city}_routes');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          city.toUpperCase(),
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: citydata.snapshots(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return Center(
                child: Text("Bir hata olustu"),
              );
            } else {
              if (asyncSnapshot.hasData) {
                return Column(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/$city/$city.jpg"),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            asyncSnapshot.data.data()['title'],
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Gezi Rotaları",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: primaryColor),
                    ),
                    Divider(),
                    StreamBuilder<DocumentSnapshot>(
                        stream: routedata.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasError) {
                            return Text("Birseyler Yanlis gitti");
                          } else {
                            if (asyncSnapshot.hasData) {
                              Map data = asyncSnapshot.data.data();
                              List<String> routes = [];
                              data.keys.forEach((element) {
                                routes.add(element.toString());
                              });
                              return Flexible(
                                child: ListView.builder(
                                  itemCount: routes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTapCancel: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(new SnackBar(
                                                    content: new Text(
                                                        'Rotaya gidilmekten vazgeçildi !')));
                                          },
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "/selectedRoutePage",
                                                  arguments: {
                                                    'city': '$city',
                                                    'routes': '${routes[index]}'
                                                  });
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    height: 100,
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/images/$city/${routes[index]}.jpg"),
                                                      ),
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                ),
                                                SpacerSizedBox(),
                                                Flexible(
                                                  child: Text(routes[index],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SpacerSizedBox(),
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }
                        })
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }
}
