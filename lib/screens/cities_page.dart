import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';
import 'package:seyyah/widgets/spacer_sizedbox.dart';

import '../widgets/main_bottom_bar.dart';

class CitiesPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Şehirler",
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: MainBottomBar().mainBottomBar(context, 1),
      body: Column(
        children: [
          SpacerSizedBox(),
          Flexible(
            child: ListView(
              children: [
                ListTile(
                  onTap: () => Navigator.pushNamed(context, "/selectedCityPage",
                      arguments: "afyonkarahisar"),
                  leading: CircleAvatar(
                    child: Text(
                      "03",
                      style: TextStyle(fontSize: 23),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: secondaryColor,
                    maxRadius: 25,
                  ),
                  title: Text(
                    "Afyonkarahisar",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, "/selectedCityPage",
                      arguments: "konya"),
                  leading: CircleAvatar(
                    child: Text(
                      "42",
                      style: TextStyle(fontSize: 23),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: secondaryColor,
                    maxRadius: 25,
                  ),
                  title: Text(
                    "Konya",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
