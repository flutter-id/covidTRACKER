import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_widget.dart';
import 'register_notifier.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterNotifier>.value(
          value: RegisterNotifier(),
        )
      ],
      child: RegisterWidget(),
    );
  }
}
