import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';

class CardSlider {
  CarouselSlider cardSlider(BuildContext context) {
    return CarouselSlider(
      items: [
        MaterialButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/selectedPointPage",
              arguments: {'city': 'afyonkarahisar', 'selectedPoint': 'Taşhan'},
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/afyonkarahisar/Taşhan.jpg"),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width / 20),
                  bottom: (MediaQuery.of(context).size.width / 30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BorderedText(
                    strokeColor: secondaryColor,
                    child: Text(
                      "Taşhan",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  BorderedText(
                    strokeColor: secondaryColor,
                    child: Text(
                      "Afyonkarhisar/Merkez",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/selectedPointPage",
              arguments: {
                'city': 'konya',
                'selectedPoint': 'İnce Minareli Medrese'
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    AssetImage("assets/images/konya/İnce Minareli Medrese.jpg"),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width / 20),
                  bottom: (MediaQuery.of(context).size.width / 30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BorderedText(
                    strokeColor: secondaryColor,
                    child: Text(
                      "İnce Minareli Medrese",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  BorderedText(
                    strokeColor: secondaryColor,
                    child: Text(
                      "Konya/Selçuklu",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 4,
        autoPlay: true,
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
