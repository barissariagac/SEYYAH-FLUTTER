import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "SEYYAH, gezmeyi seven insanlara mobil tur rehberi uygulamasıdır. Kullanıcıların gezmek istedikleri şehri seçip, kendilerine uygun rotayı belirleyerek özgür ve rahat bir şekilde gezmeleri amaçlanmaktadır.",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: secondaryColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: Text(
                  "Geri",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
