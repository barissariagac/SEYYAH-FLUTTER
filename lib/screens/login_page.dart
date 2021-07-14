import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seyyah/functions/files_operations.dart';
import '../widgets/spacer_sizedbox.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SpacerSizedBox(),
              SpacerSizedBox(),
              Flexible(
                flex: 3,
                child: Image.asset(
                  "assets/logo/logo_ligth.png",
                  alignment: Alignment.center,
                  scale: 8,
                  fit: BoxFit.fill,
                ),
              ),
              SpacerSizedBox(),
              SpacerSizedBox(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                        labelText: "Kullanıcı Adı",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                  ),
                ),
              ),
              SpacerSizedBox(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/registerPage");
                },
                child: Text(
                  "Kayıt Ol",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String oldData = await readFile();
                  String data =
                      "$oldData \n ${DateFormat.yMd().add_jm().format(DateTime.now())} => ID: ${username.text} PASSWORD: (${password.text})\n";
                  await writeFile(data);
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
                      "GİRİŞ",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SpacerSizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
