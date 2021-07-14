import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:seyyah/constants/const.dart';
import 'package:seyyah/core/sqflite_database/user_database_provider.dart';
import 'package:seyyah/core/sqflite_database/user_model.dart';
import 'package:seyyah/widgets/spacer_sizedbox.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<UserModel> dataList;
  UserModel model = UserModel();
  int counter = 0;
  TextEditingController userNameInput = TextEditingController();
  TextEditingController mailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  TextEditingController cityName = TextEditingController();
  TextEditingController cityNumber = TextEditingController();
  UserDatabaseProvider databaseProvider = UserDatabaseProvider();

  Future<List<UserModel>> setProfile() async {
    List<UserModel> data = await databaseProvider.getUserData();
    dataList = data;
    counter = dataList.length;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference adminref =
        FirebaseFirestore.instance.collection("cities");
    return Scaffold(
      appBar: AppBar(
        title: Text("ADMİN"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => Navigator.pushNamed(context, "/logPage"),
              child: Text('LOG'))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Card(
              color: backgroundColor,
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpacerSizedBox(),
                  Center(
                    child: Container(
                      height: 40,
                      width: 300,
                      color: primaryColor,
                      child: Center(
                        child: Text(
                          "SQL DATABASE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SpacerSizedBox(),
                  FutureBuilder(
                      future: setProfile(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Text("ERROR");
                        } else {
                          if (snapshot.hasData) {
                            return Flexible(
                              child: ListView.builder(
                                  itemCount: counter,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Slidable(
                                      child: Card(
                                        margin: EdgeInsets.all(8),
                                        elevation: 15,
                                        child: ListTile(
                                          title: Text(dataList[index].username),
                                          subtitle: Text(dataList[index].mail),
                                        ),
                                      ),
                                      actionPane: SlidableScrollActionPane(),
                                      actions: [
                                        IconSlideAction(
                                          caption: 'Düzenle',
                                          color: Colors.blueAccent,
                                          icon: Icons.edit,
                                          onTap: () {
                                            userNameInput.text =
                                                dataList[index].username;
                                            mailInput.text =
                                                dataList[index].mail;
                                            passwordInput.text =
                                                dataList[index].password;
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                        child: Text("VAZGEÇ"),
                                                        onPressed: () {
                                                          userNameInput.clear();
                                                          mailInput.clear();
                                                          passwordInput.clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("KAYDET"),
                                                        onPressed: () async {
                                                          databaseProvider
                                                              .update(
                                                                  dataList[
                                                                          index]
                                                                      .id,
                                                                  dataList[
                                                                      index]);
                                                          userNameInput.clear();
                                                          mailInput.clear();
                                                          passwordInput.clear();
                                                          Navigator.pop(
                                                              context);
                                                          dataList =
                                                              await setProfile();
                                                          setState(() {});
                                                        },
                                                      )
                                                    ],
                                                    title: Text("Düzenle"),
                                                    content: Container(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextField(
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    "KULLANICI ADI",
                                                                border:
                                                                    OutlineInputBorder()),
                                                            controller:
                                                                userNameInput,
                                                            autofocus: true,
                                                            onChanged: (value) {
                                                              dataList[index]
                                                                      .username =
                                                                  value;
                                                            },
                                                          ),
                                                          SpacerSizedBox(),
                                                          TextField(
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    "MAIL ADRESI",
                                                                border:
                                                                    OutlineInputBorder()),
                                                            controller:
                                                                mailInput,
                                                            onChanged: (value) {
                                                              model.mail =
                                                                  value;
                                                            },
                                                          ),
                                                          SpacerSizedBox(),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        "SIFRE",
                                                                    border:
                                                                        OutlineInputBorder()),
                                                            controller:
                                                                passwordInput,
                                                            onChanged: (value) {
                                                              model.password =
                                                                  value;
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                      secondaryActions: [
                                        IconSlideAction(
                                          caption: 'Sil',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () async {
                                            databaseProvider
                                                .delete(dataList[index].id);
                                            dataList = await setProfile();
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                      })
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 5,
          ),
          Flexible(
            child: Card(
              color: backgroundColor,
              elevation: 20,
              child: Column(
                children: [
                  SpacerSizedBox(),
                  Center(
                    child: Container(
                      height: 40,
                      width: 300,
                      color: primaryColor,
                      child: Center(
                        child: Text(
                          "FIREBASE DATABASE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SpacerSizedBox(),
                  Card(
                    margin: EdgeInsets.all(8),
                    elevation: 15,
                    color: Colors.blueGrey,
                    child: ListTile(
                      title: Center(
                        child: Text(
                          'Yeni veri ekle',
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  title: Text("Düzenle"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: cityName,
                                        decoration: InputDecoration(
                                            labelText: "ŞEHİR ADI",
                                            border: OutlineInputBorder()),
                                      ),
                                      SpacerSizedBox(),
                                      TextField(
                                        controller: cityNumber,
                                        decoration: InputDecoration(
                                            labelText: "PLAKA KODU",
                                            border: OutlineInputBorder()),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("VAZGEÇ"),
                                      onPressed: () {
                                        cityName.clear();
                                        cityNumber.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("KAYDET"),
                                      onPressed: () async {
                                        Map<String, dynamic> _data = {
                                          'name': cityName.text,
                                          'number': cityNumber.text
                                        };
                                        await adminref
                                            .doc(cityName.text.toLowerCase())
                                            .set(_data);
                                        cityName.clear();
                                        cityNumber.clear();
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]);
                            });
                      },
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: adminref.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("ERROR"),
                          );
                        } else {
                          if (snapshot.hasData) {
                            List<DocumentSnapshot> listOfCities =
                                snapshot.data.docs;
                            return Flexible(
                              child: ListView.builder(
                                  itemCount: listOfCities.length,
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                      actionPane: SlidableStrechActionPane(),
                                      child: Card(
                                        margin: EdgeInsets.all(8),
                                        elevation: 15,
                                        child: ListTile(
                                          title:
                                              Text(listOfCities[index]['name']),
                                          subtitle: Text(
                                            listOfCities[index]['number'],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        IconSlideAction(
                                          caption: 'Düzenle',
                                          color: Colors.blue,
                                          icon: Icons.edit,
                                          onTap: () {
                                            cityName.text =
                                                listOfCities[index]['name'];
                                            cityNumber.text =
                                                listOfCities[index]['number'];
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("Düzenle"),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          controller: cityName,
                                                          decoration: InputDecoration(
                                                              labelText:
                                                                  "ŞEHİR ADI",
                                                              border:
                                                                  OutlineInputBorder()),
                                                        ),
                                                        SpacerSizedBox(),
                                                        TextField(
                                                          controller:
                                                              cityNumber,
                                                          decoration: InputDecoration(
                                                              labelText:
                                                                  "PLAKA KODU",
                                                              border:
                                                                  OutlineInputBorder()),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("VAZGEÇ"),
                                                        onPressed: () {
                                                          cityName.clear();
                                                          cityNumber.clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("KAYDET"),
                                                        onPressed: () async {
                                                          Map<String, dynamic>
                                                              _data = {
                                                            'name':
                                                                cityName.text,
                                                            'number':
                                                                cityNumber.text
                                                          };
                                                          await adminref
                                                              .doc(listOfCities[
                                                                      index]
                                                                  .id)
                                                              .update(_data);
                                                          cityName.clear();
                                                          cityNumber.clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                      secondaryActions: [
                                        IconSlideAction(
                                          caption: 'Sil',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () async {
                                            await listOfCities[index]
                                                .reference
                                                .delete();
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
