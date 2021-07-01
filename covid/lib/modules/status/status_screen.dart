import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'status_widget.dart';
import 'status_notifier.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StatusNotifier>.value(
          value: StatusNotifier(),
        )
      ],
      child: StatusWidget(),
    );
  }
}
