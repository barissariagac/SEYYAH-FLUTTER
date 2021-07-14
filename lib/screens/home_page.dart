import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';

import '../widgets/card_slider.dart';
import '../widgets/main_bottom_bar.dart';
import '../widgets/spacer_sizedbox.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MainBottomBar().mainBottomBar(context, 0),
        body: Column(
          children: [
            SpacerSizedBox(),
            CardSlider().cardSlider(context),
            SpacerSizedBox(),
            Text(
              "Rota Listesi",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: primaryColor),
            ),
            Divider(),
            Flexible(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/selectedRoutePage",
                              arguments: {
                                'city': 'konya',
                                'routes': 'Mevlevi Yolu'
                              });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              height: MediaQuery.of(context).size.height / 10.5,
                              width: MediaQuery.of(context).size.width / 3.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/konya/İnce Minareli Medrese.jpg"),
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            SpacerSizedBox(),
                            Text(
                              "Mevlevi Yolu",
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      ),
                      SpacerSizedBox(),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/selectedRoutePage",
                              arguments: {
                                'city': 'afyonkarahisar',
                                'routes': 'Karahisar Gezmesi'
                              });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              height: MediaQuery.of(context).size.height / 10.5,
                              width: MediaQuery.of(context).size.width / 3.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/afyonkarahisar/Karahisar Gezmesi.jpg"),
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            SpacerSizedBox(),
                            Text(
                              "Karahisar Gezmesi",
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
