import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'layout_widget.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LayoutNotifier>.value(
          value: LayoutNotifier(),
        ),
      ],
      child: LayoutWidget(),
    );
  }
}
