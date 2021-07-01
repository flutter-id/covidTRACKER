import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_widget.dart';
import 'login_notifier.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginNotifier>.value(
          value: LoginNotifier(),
        )
      ],
      child: LoginWidget(),
    );
  }
}
