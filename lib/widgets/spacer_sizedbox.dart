import 'package:flutter/material.dart';

class SpacerSizedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 40,
      width: MediaQuery.of(context).size.width / 40,
    );
  }
}
