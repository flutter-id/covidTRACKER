import 'package:flutter/material.dart';
import 'modules/layout/layout_screen.dart';
import 'constants/string_constant.dart';

void main() => runApp(Lancong());

class Lancong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: LayoutScreen(),
    );
  }
}
