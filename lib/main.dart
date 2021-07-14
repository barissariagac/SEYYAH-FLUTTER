import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';
import 'settings/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(backgroundColor: primaryColor),
          scaffoldBackgroundColor: backgroundColor),
      title: 'SEYYAH',
      onGenerateRoute: Routes.generateRoute,
      initialRoute: splashRoute,
    );
  }
}
