import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  String text = '';

  NoDataWidget({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/no_Data.png',
          height: 150,
          width: 150,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
