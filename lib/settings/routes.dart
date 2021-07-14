import 'package:flutter/material.dart';
import 'package:seyyah/screens/admin_page.dart';
import 'package:seyyah/screens/app_info_page.dart';
import 'package:seyyah/screens/log_page.dart';
import 'package:seyyah/screens/statistics_page.dart';
import '../screens/selected_city.dart';
import '../screens/selected_point.dart';
import '../screens/selected_route.dart';
import '../screens/home_page.dart';
import '../screens/login_page.dart';
import '../screens/profile_page.dart';
import '../screens/splash_page.dart';
import '../screens/cities_page.dart';
import '../screens/information_page.dart';
import '../screens/more_page.dart';
import '../screens/register_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SplashPage());
      case loginRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginPage());
      case registerRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => RegisterPage());
      case homeRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomePage());
      case citiesRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => CitiesPage());
      case selectedCityRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SelectedCity());
      case selectedRouteRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SelectedRoute());
      case selectedPointRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SelectedPoint());
      case moreRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => MorePage());
      case profileRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ProfilePage());
      case informationRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => InformationPage());
      case statisticsRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => StatisticsPage());
      case adminRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => AdminPage());
      case logRoute:
        return MaterialPageRoute(settings: settings, builder: (_) => LogPage());
      case appInfoRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => AppInfoPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                "Ters giden bir şeyler oldu !",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
    }
  }
}

const String splashRoute = "/";
const String loginRoute = "/loginPage";
const String registerRoute = "/registerPage";
const String homeRoute = "/homePage";
const String citiesRoute = "/citiesPage";
const String selectedCityRoute = "/selectedCityPage";
const String selectedRouteRoute = "/selectedRoutePage";
const String selectedPointRoute = "/selectedPointPage";
const String moreRoute = "/morePage";
const String profileRoute = "/profilePage";
const String informationRoute = "/informationPage";
const String statisticsRoute = "/statisticsPage";
const String adminRoute = "/adminPage";
const String logRoute = "/logPage";
const String appInfoRoute = "/appInfoPage";
