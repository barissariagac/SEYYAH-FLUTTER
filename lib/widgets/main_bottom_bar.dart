import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';

class MainBottomBar {
  Map<int, String> bottomBar = {
    0: "/homePage",
    1: "/citiesPage",
    2: "/morePage"
  };

  BottomNavigationBar mainBottomBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        if (index != currentIndex) {
          Navigator.pushNamedAndRemoveUntil(
              context, bottomBar[index], (route) => false);
        }
      },
      selectedItemColor: bottomSelectedColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Ana Sayfa",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_city),
          label: "Şehirler",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: "Daha",
        )
      ],
    );
  }
}
