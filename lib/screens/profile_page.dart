import 'package:flutter/material.dart';
import 'package:seyyah/constants/const.dart';
import 'package:seyyah/core/sqflite_database/user_database_provider.dart';
import 'package:seyyah/core/sqflite_database/user_model.dart';
import '../widgets/spacer_sizedbox.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel userProfile;
  UserDatabaseProvider databaseProvider = UserDatabaseProvider();
  Future<int> setProfile() async {
    var list = await databaseProvider.getUserData();
    userProfile = list.last;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: setProfile(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return Center(
                child: Text("Bir Hata Olustu"),
              );
            } else {
              if (asyncSnapshot.hasData) {
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 200,
                        color: primaryColor,
                      ),
                      SpacerSizedBox(),
                      Text(
                        "Kullanıcı Adı",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        userProfile.username,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SpacerSizedBox(),
                      SpacerSizedBox(),
                      Text(
                        "E-posta Adresi",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        userProfile.mail,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SpacerSizedBox(),
                      SpacerSizedBox(),
                      SpacerSizedBox(),
                      SpacerSizedBox(),
                      SpacerSizedBox(),
                      SpacerSizedBox(),
                      SpacerSizedBox(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/loginPage", (route) => false);
                          });
                        },
                        child: Container(
                          height: 70,
                          width: 200,
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Center(
                            child: Text(
                              "Çıkış Yap",
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
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          },
        ));
  }
}
/*
    */