import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seyyah/core/sqflite_database/user_database_provider.dart';
import 'package:seyyah/core/sqflite_database/user_model.dart';
import 'package:seyyah/functions/files_operations.dart';
import 'package:http/http.dart' as http;

import '../widgets/spacer_sizedbox.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mail = TextEditingController();
  UserDatabaseProvider databaseProvider = UserDatabaseProvider();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Flexible(
              flex: 5,
              child: Icon(
                Icons.account_box_rounded,
                size: 200,
              ),
            ),
            SpacerSizedBox(),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                      labelText: "Kullanıcı Adı",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                ),
              ),
            ),
            Flexible(child: SpacerSizedBox()),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: mail,
                  decoration: InputDecoration(
                      labelText: "E-posta Adresi",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                ),
              ),
            ),
            Flexible(child: SpacerSizedBox()),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Şifre",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                ),
              ),
            ),
            SpacerSizedBox(),
            SpacerSizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "İptal Et",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var data = UserModel(
                        mail: mail.text,
                        password: password.text,
                        username: username.text);
                    await databaseProvider.insert(data);
                    String oldData = await readFile();
                    String logData =
                        "$oldData \n ${DateFormat.yMd().add_jm().format(DateTime.now())} => ID: ${username.text} PASSWORD: (${password.text})\n";
                    await writeFile(logData);
                    String apiUrl = "https://reqres.in/api/users";
                    final response = await http.post(Uri.parse(apiUrl),
                        body: {"name": username.text, "mail": mail.text});
                    if (response.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "${username.text} adlı kullanıcı ${mail.text} mail adresi ile kaydolmuştur")));
                    }
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/homePage", (route) => false);
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "Kayıt Ol",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
