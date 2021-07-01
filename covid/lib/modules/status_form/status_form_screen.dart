import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'status_form_widget.dart';
import 'status_form_notifier.dart';

class StatusFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StatusFormNotifier>.value(
          value: StatusFormNotifier(),
        )
      ],
      child: StatusFormWidget(),
    );
  }
}
